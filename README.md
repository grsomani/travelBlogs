# Travel Blog

Show list of blogs by various users along with media, likes and comments.
Show a list of users and their details.
Store items to database and fetch them in-case of network failure.

## Features:
 - Articles list
 - Users List
 - Disk cache for images
 - Core Data implementation to store articles and users.
 - iPhone and iPad with orientation support.
 - Dark Mode support.
 - Pagination and offset to fetch correct next page from local database.

## Areas on improvement:
 - Database normalisation as users in article and users in user list have same data.
 - Inverse linking of database (Deletion of users to delete articles)
 
 ## Know issues:
 - On Initial table load, willDisplay cause API call for second page too.


## References: 

- https://matteomanferdini.com/network-requests-rest-apis-ios-swift/
- https://stackoverflow.com/questions/36376897/swift-2-0-format-1000s-into-a-friendly-ks
- https://gist.github.com/amosavian/a05044e57c290b5e064f4f7acfc3b506
