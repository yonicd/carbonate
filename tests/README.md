Tests and Coverage
================
04 October, 2018 22:14:05

This output is created by
[covrpage](https://github.com/yonicd/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                               | Coverage (%) |
| :--------------------------------------------------- | :----------: |
| carbonate                                            |    50.36     |
| [R/carbonate.R](../R/carbonate.R)                    |     0.00     |
| [R/selenium\_functions.R](../R/selenium_functions.R) |     0.00     |
| [R/uri\_functions.R](../R/uri_functions.R)           |    54.39     |
| [R/carbon.R](../R/carbon.R)                          |    64.29     |
| [R/helpers.R](../R/helpers.R)                        |    78.95     |
| [R/set\_get\_functions.R](../R/set_get_functions.R)  |    100.00    |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat)
package.

|            | file                              | n |  time | error | failed | skipped | warning |
| ---------- | :-------------------------------- | -: | ----: | ----: | -----: | ------: | ------: |
| test-set.R | [test-set.R](testthat/test-set.R) | 3 | 0.004 |     0 |      0 |       0 |       0 |
| test-uri.R | [test-uri.R](testthat/test-uri.R) | 8 | 1.224 |     0 |      0 |       0 |       0 |
| test-yml.R | [test-yml.R](testthat/test-yml.R) | 6 | 0.013 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results
</summary>

| file                                  | context | test                                        | status | n |  time |
| :------------------------------------ | :------ | :------------------------------------------ | :----- | -: | ----: |
| [test-set.R](testthat/test-set.R#L8)  | set\_   | set functions: set\_template                | PASS   | 1 | 0.002 |
| [test-set.R](testthat/test-set.R#L13) | set\_   | set functions: set\_font\_family            | PASS   | 1 | 0.001 |
| [test-set.R](testthat/test-set.R#L18) | set\_   | set functions: set\_windows\_control\_theme | PASS   | 1 | 0.001 |
| [test-uri.R](testthat/test-uri.R#L9)  | uri     | options: benchmark                          | PASS   | 1 | 0.001 |
| [test-uri.R](testthat/test-uri.R#L17) | uri     | uri: benchmark                              | PASS   | 1 | 0.001 |
| [test-uri.R](testthat/test-uri.R#L21) | uri     | uri: 200                                    | PASS   | 1 | 0.063 |
| [test-uri.R](testthat/test-uri.R#L27) | uri     | encode: encode character                    | PASS   | 1 | 0.002 |
| [test-uri.R](testthat/test-uri.R#L31) | uri     | encode: no encode character                 | PASS   | 1 | 0.001 |
| [test-uri.R](testthat/test-uri.R#L37) | uri     | tiny: valid tiny                            | PASS   | 1 | 0.651 |
| [test-uri.R](testthat/test-uri.R#L43) | uri     | tiny: clipboard                             | PASS   | 1 | 0.503 |
| [test-uri.R](testthat/test-uri.R#)    | uri     | bad template: error uri                     | PASS   | 1 | 0.002 |
| [test-yml.R](testthat/test-yml.R#L24) | yml     | yaml fields: rgba                           | PASS   | 1 | 0.003 |
| [test-yml.R](testthat/test-yml.R#L29) | yml     | yaml fields: template                       | PASS   | 1 | 0.002 |
| [test-yml.R](testthat/test-yml.R#L34) | yml     | yaml fields: bad font family                | PASS   | 1 | 0.002 |
| [test-yml.R](testthat/test-yml.R#L39) | yml     | yaml fields: pv                             | PASS   | 1 | 0.003 |
| [test-yml.R](testthat/test-yml.R#L44) | yml     | yaml fields: ph                             | PASS   | 1 | 0.002 |
| [test-yml.R](testthat/test-yml.R#L59) | yml     | namesless palette: fill in palette          | PASS   | 1 | 0.001 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                               |
| :------- | :---------------------------------- |
| Version  | R version 3.5.1 (2018-07-02)        |
| Platform | x86\_64-apple-darwin15.6.0 (64-bit) |
| Running  | macOS High Sierra 10.13.6           |
| Language | en\_US                              |
| Timezone | America/New\_York                   |

| Package  | Version    |
| :------- | :--------- |
| testthat | 2.0.0.9000 |
| covr     | 3.2.0      |
| covrpage | 0.0.58     |

</details>

<!--- Final Status : pass --->
