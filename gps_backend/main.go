package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"
)

type locationData struct {
	Longitude float32   `json:"longitude"`
	Latitude  float32   `json:"latitude"`
	Altitude  float32   `json:"altitude"`
	Userid    string    `json:"user_id"`
	Time      time.Time `json:"recorded_at"`
}

func main() {
	databaseurl := os.Getenv("DATABASE_URL")
	if databaseurl == "" {
		databaseurl = "postgres://postgres:Tequiero1!@localhost:5432/postgres"

	}

	config, err := pgxpool.ParseConfig(databaseurl)
	if err != nil {
		log.Fatalf("the database failed to parse error code:%v", err)
	}
	dbpool, err := pgxpool.NewWithConfig(context.Background(), config)
	if err != nil {
		log.Fatalf("unable to connect to a database error code:%v", err)
	}
	defer dbpool.Close()
	err = dbpool.Ping(context.Background())
	if err != nil {
		log.Fatalf("database isnt online at the moment.errorcode:%v", err)
	}
	fmt.Println("the databse is online.")
	http.HandleFunc("/ping", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "GPS tracker backend is online.")
	})

	http.HandleFunc("/api/v1/location", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodPost {
			fmt.Println("Method not allowed")
			http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
			return
		}
		var loc []locationData
		err := json.NewDecoder(r.Body).Decode(&loc)
		if err != nil {
			fmt.Println("invalid json transmitted.")
			http.Error(w, "invalid json transmitted.", http.StatusNotAcceptable)
			return
		}
		query := "insert into gpscoords(longitude,latitude,altitude,user_id,recorded_at) values ($1,$2,$3,$4,$5) on conflict (recorded_at,user_id) do nothing"
		for _, coord := range loc {
			_, err := dbpool.Exec(r.Context(), query, coord.Longitude, coord.Latitude, coord.Altitude, coord.Userid, coord.Time)
			if err != nil {
				log.Printf("error in saving the value of longitude and latitude %v", err)
				http.Error(w, "error occured", http.StatusInternalServerError)
				return
			}
		}
	})

	http.HandleFunc("/get/data", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodGet {
			fmt.Println("error the address can only be used to get the data")
			http.Error(w, "error the address can only be used to get the data", http.StatusBadRequest)
			return
		}
		loc := []locationData{}
		deviceid := r.URL.Query().Get("deviceid")
		query := "select longitude,latitude,altitude,created_at from gpscoords where user_id = $1"
		rows, getdata := dbpool.Query(r.Context(), query, deviceid)
		if getdata != nil {
			fmt.Println("query failed")
			http.Error(w, "database error", http.StatusBadRequest)
			return
		}
		defer rows.Close()

		for rows.Next() {
			dataset := locationData{}
			err = rows.Scan(&dataset.Longitude, &dataset.Latitude, &dataset.Altitude, &dataset.Time)
			if err != nil {
				fmt.Printf("error occured.%v", err)
				http.Error(w, "error in retrieving the data", http.StatusNoContent)
				return
			}
			loc = append(loc, dataset)

		}
		if err := rows.Err(); err != nil {
			fmt.Println("error in iterating the data.")
			http.Error(w, "error in iterating the data.", http.StatusInternalServerError)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(loc)
	})

	fmt.Println("The Server is running on port 8080")
	err = http.ListenAndServe(":8080", nil)
	if err != nil {
		fmt.Printf("error starting server:%S", err)
	}
}
