# Copyright 2016 Google Inc. All rights reserved.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to writing, software distributed
# under the License is distributed on a "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied.
#
# See the License for the specific language governing permissions and
# limitations under the License.

token.json:
	go run cmd/auth/main.go
build: token.json */*.go *.go
	CGO_ENABLED=0 GOOS=linux go build -o app
	docker build -t $(USER)/podcast-to-youtube .
	rm -f app

run: build
	docker run --rm -it $(USER)/podcast-to-youtube

.PHONY: build run