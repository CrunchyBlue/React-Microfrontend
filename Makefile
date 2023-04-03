build: run_container run_marketing run_auth run_dashboard

run_container:
	npm run --prefix ./container start
    
run_marketing:
	npm run --prefix ./marketing start
    
run_auth:
	npm run --prefix ./auth start
    
run_dashboard:
	npm run --prefix ./dashboard start