# git-server-docker
Легковесный Git-сервер с доступом по SSH, запускается из образа Docker.

### Порядок работы
- На сервере подготовить директории для обмена файлами.<br>
`sudo mkdir -pm 777 /git-server/keys /git-server/repos`

- Скопировать ПУБЛИЧНЫЙ ключ клиента в директорию `/git-server/keys` (см. ниже).<br>
Если контейнер уже запущен, его после этого придётся перезапустить:<br>
`docker compose restart git-server`

- Поместить репозиторий в директорию `/git-server/repos` (см. ниже)

- Запустить контейнер

---

#### Как создать репозиторий на сервере из локального репозитория:
Рядом с каталогом репозитория  (пусть будет `myrepo`) выполнить команду<br>
`git clone --bare myrepo myrepo.git`<br>
Появится новая директория `myrepo.git`, её надо перенести на сервер в `/git-server/repos`:<br>
`scp -r myrepo.git user@host:/git-server/repos`

#### Как клонировать репозиторий на клиенте:
`git clone ssh://git@host:2222/git-server/repos/myrepo.git`

#### Как создать ключ на машине клиента:
`ssh-keygen -t ed25519`

#### Как скопировать ПУБЛИЧНЫЙ ключ на сервер:
`scp ~/.ssh/id_ed25519.pub user@host:/git-server/keys`

#### Компиляция образа
`docker build -t git-server .`

#### Запуск контейнера
`docker compose up -d`

#### Сохранение образа в файл
`docker save git-server | gzip -9 > git-server.tar.gz`

#### Загрузка образа из файла
`docker load -i git-server.tar.gz`
