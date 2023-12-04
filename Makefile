
SERVER_PORT:=2000

.PHONY: dump
dump:
	python manage.py dumpdata > db.json


dump_app: c:=${c}
dump_app:
	python manage.py dumpdata $(c) > $(c).json

.PHONY: restore
restore:
	python manage.py flush --noinput
	python manage.py loaddata db.json

.PHONY: migrate
migrate:
	python manage.py makemigrations && python manage.py migrate

.PHONY: server
server:
	python manage.py runserver $(SERVER_PORT)

.PHONY: admin
admin:
	python manage.py shell -c "from django.contrib.auth import get_user_model; \
		get_user_model().objects.filter(username='admin').exists() or \
		get_user_model().objects.create_superuser('admin', 'admin@admin.com', 'admin')"

.PHONY: rm
rm:
	rmdir __pycache__ /s /q
	del db.sqlite3
