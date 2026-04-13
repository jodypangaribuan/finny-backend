# Build stage
FROM golang:alpine AS builder

# Set working directory di dalam container
WORKDIR /app

# Menyalin file konfigurasi Go modules
COPY go.mod go.sum ./
RUN go mod download

# Menyalin seluruh source code
COPY . .

# Build aplikasi Go menjadi binary executable statis
RUN CGO_ENABLED=0 GOOS=linux go build -o /api-server main.go

# Final stage (menggunakan image alpine yang sangat kecil)
FROM alpine:latest

# Set working directory
WORKDIR /app

# Salin binary dari stage builder sebelumnya
COPY --from=builder /api-server /app/api-server

# Expose port 8080 agar bisa diakses dari luar container
EXPOSE 8080

# Jalankan aplikasi saat container dimulai
CMD ["/app/api-server"]
