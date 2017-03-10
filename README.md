Strings - The String Theory Web Site
------------------------------------

               .=     ,        =.
       _  _   /'/    )\,/,/(_   \ \
         `//-.|  (  ,\\)\//\)\/_  ) |
        //___\   `\\\/\\/\/\\///'  /
    ,-"~`-._ `"--'_   `"""`  _ \`'"~-,_
    \       `-.  '_`.      .'_` \ ,-"~`/
      `.__.-'`/   (-\        /-) |-.__,'
        ||   |     \O)  /^\ (O/  |
        `\\  |         /   `\    /
          \\  \       /      `\ /
          `\\ `-.  /' .---.--.\
            `\\/`~(, '()      ('
              /(O) \\   _,.-.,_)
            //  \\ `\'`      /
           / |  ||   `""""~"`
          /'  |__||
                `o


* **strings-server** - APIs Backend
  * README.md
* **strings-client** - Frontend
  * README.md

1. [Backend][1]  - ``Ruby on Rails``, **v5.0.1**
2. [Frontend][2] - ``Ember.js``, **v2.10.2**
3. [Database][3] - ``Rethinkdb``, **v2.3**
4. [Cache][4]    - ``Redis``, **v3.2.6**

> What is Rethink DB?

Rethink database is an open-source database which is one of the best
query languages with respect to other databases. Rethink DB’s push
functionality is extremely helpful to build a real-time applications.
RethinkDB supports server-side subqueries and distributed join
operations which exclude complex client-side code and multiple network
roundtrips to database server. As RethinkDB is not based on string
parsing, the risk of injection attack is minimized at high level.

RethinkDB is designed in such a way that it is easy to use and install.
In addition, it has a rich data model and supports flexible querying
capabilities. It has incredible admin interface having a web-based
dashboard. The built-in data explorer offers online documentation and
query language suggestions.

> What is ReQL?

ReQL, a form of Rethink query language is a data-driven, abstract and
polymorphic query language. All cluster operations are scriptable in
ReQL. Rethink database model is a JSON document store based on
JavaScript-based query language. Its partitioning method is based on
sharded cluster model and has a built-in replication. A cluster node can
be sharded through couple of clicks. Apart from it, data is JOIN-able on
references, handles BLOBS, and supports geospatial and multi-datacenter.
High-level operations on data are automatically compiled to map-reduce
jobs that are an added advantage of distributed architecture.

> Limitations of RethinkDB:

Using RethinkDB will not be a good choice, if you need full ACID support
or strong enforcement. In such cases, it is better to use relational
databases. RethinkDB can be a great choice but it is low in performance
if compared to Cassandra in both single node and multiple-node
configurations. RethinkDB has no user accounts and you will have to
setup your own auth and user accounts. Furthermore, there is no hard
limit on the creation of databases but there is a hard limit of 64
shards.

> Benefits of RethinkDB over Cassandra:

CQL, a Cassandra query language is similar to SQL, but it has
scalability issues, because it has no JOINS and aggregate functions.
Rethink DB supports map-reduce which is a way to run aggregation
functions on large data sets, potentially stored across many servers.
Rethink DB’s real-time push architecture dramatically reduces time and
effort necessary to build scalable real-time apps.

> RethinkDB works best with?

RethinkDB can be used in applications where you need continuous
real-time data updates. Additionally, it can be best used to showcase
sports score on various online displays, monitoring systems, fast
workflow applications.

> Currently, the following roles are available in Enterprise:

* **Admins:** Full account access
* **Manager:** Can invite members, create teams, and view all prototypes
* **Contributor:** Can create and edit prototypes they are on
* **Reviewer:** Can be assigned prototypes to review

### 10 Mar 2017 Oleg G.Kapranov

[1]: http://rubyonrails.org/
[2]: http://emberjs.com/
[3]: https://rethinkdb.com/
[4]: https://redis.io/
