# Propery Finder  JSON API (RAILS 6)

A RESTFUL API built with Ruby on Rails. To implement Authentication and Authorization JWT is used. It is a back-end project built as part of the final capstone application at Microverse. The repo for the client app can be accessed [here](https://github.com/temesghentekeste/property-finder-react)

<div align="center">

[![View Code](https://img.shields.io/badge/View%20-Code-green)](https://github.com/temesghentekeste/proprty-finder-api)
[![Github Issues](https://img.shields.io/badge/GitHub-Issues-orange)](https://github.com/temesghentekeste/proprty-finder-api/issues)
[![GitHub Pull Requests](https://img.shields.io/badge/GitHub-Pull%20Requests-blue)](https://github.com/temesghentekeste/proprty-finder-api/pulls)

</div>

## 📝 Content

<p align="center">
<a href="#with">Built with</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
<a href="#deploy">Deploy Live</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
<a href="#live">API Endpoints</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
<a href="#start">Getting Started</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
<a href="#test">Test</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
<a href="#author">Author</a>
</p>

## 🔧 Built with<a name = "with"></a>

- [ ] Ruby 2.7.2
- [ ] Rails 6.1.4
- [ ] Bcrypt 3.1
- [ ] Postgresql
- [ ] Cloudinary
- [ ] Fast JSON API
- [ ] JWT

## :heavy_check_mark: Getting Started <a name = "start"></a>

- [ ] git clone [https://github.com/temesghentekeste/proprty-finder-api](https://github.com/temesghentekeste/proprty-finder-api/tree/develop)
- [ ] cd proprty-finder-api
- [ ] bundle install
- [ ] rails db:create
- [ ] rails db:migrate
- [ ] rails db:seed
- [ ] rails start
- [ ] Setup cloudinary for image uploading

## :eyes: Run Tests <a name = "test"></a>

- [ ] cd proprty-finder-api
- [ ] rspec

## 🔴 Deploy to a live server <a name = "deploy"></a>


Deploying to a live server like Heroku is easy, make sure you have the necessary credentials setup on your local machine

```bash
heroku create
heroku rename app-new-name
git push heroku $BRANCH_NAME:main 
```
If you are already in main branch no need to add $BRANCH_NAME, just use `git push heroku main`

### 🔴 Before creating and migrating your db you need to set up cloudinary add on


```bash
heroku run rails db:migrate
heroku run rails db:seed
heroku open
```

Enjoy your newly deployed rails API

## 🔴 API Endpoints <a name = "live"></a>

## Current API Endpoints

The API will expose the following RESTful endpoints.
### Local BaseUrl: {Host-URL}/api/v1
### Live BaseUrl: {Host-URL}/api/v1

|-------------------------------|------------------------------|
| API Endpoint                  | Functionality                |
|-------------------------------|------------------------------|
| POST /users                   | Signup                       |
| POST /tokens                  | Login                        |
| GET /users                    | List all users               |
| GET /users/:id                | Show a user                  |
| DELETE /user/:id              | Delete a user                |
| GET /dashboard                | Get user dashboard           |
| -------------------------------------------------------------|
| GET /properties               | List all properties          |
| GET /properties/:id           | Show a property              |
| POST /properties              | Add a new property           |
| DELETE /properties/:id        | Delete a property            |
| PUT /properties/:id           | Update a property            |
|-------------------------------|------------------------------|
| POST /favorites               | Add favorites property       |
| GET /favorites                | Get user favorites properties|
| DELETE /favorites/:id         | Delete a favorite            |
|-------------------------------|------------------------------|



## Author <a name = "author"></a>

👤 **Temesghen Tekeste**

- Github: [@temesghentekeste](https://github.com/temesghentekeste)
- Twitter: [@temesghentekes1](https://twitter.com/temesghentekes1)
- Linkedin: [temsghen-tekeste](https://www.linkedin.com/in/temesghentekeste/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/temesghentekeste/proprty-finder-api/issues).

## 👍 Show your support

Give a ⭐️ if you like this project!

## :clap: Acknowledgements

- Stack Overflow: [@stackoverflow](https://stackoverflow.com/)
- Microverse: [@microverse](https://www.microverse.org/)

```

```
