Tests and Coverage
================
03 September, 2018 07:42:21

This output is created by
[covrpage](https://github.com/yonicd/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                               | Coverage (%) |
| :--------------------------------------------------- | :----------: |
| carbonate                                            |    52.49     |
| [R/carbonate.R](../R/carbonate.R)                    |     0.00     |
| [R/selenium\_functions.R](../R/selenium_functions.R) |     0.00     |
| [R/uri\_functions.R](../R/uri_functions.R)           |    48.94     |
| [R/carbon.R](../R/carbon.R)                          |    64.29     |
| [R/helpers.R](../R/helpers.R)                        |    81.25     |
| [R/set\_get\_functions.R](../R/set_get_functions.R)  |    100.00    |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat)
package.

|            | file                              | n |  time | error | failed | skipped | warning |
| ---------- | :-------------------------------- | -: | ----: | ----: | -----: | ------: | ------: |
| test-set.R | [test-set.R](testthat/test-set.R) | 3 | 0.021 |     0 |      0 |       0 |       0 |
| test-uri.R | [test-uri.R](testthat/test-uri.R) | 8 | 1.022 |     0 |      0 |       0 |       0 |
| test-yml.R | [test-yml.R](testthat/test-yml.R) | 6 | 0.015 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results
</summary>

| file                                  | context | test                                        | status | n |  time |
| :------------------------------------ | :------ | :------------------------------------------ | :----- | -: | ----: |
| [test-set.R](testthat/test-set.R#L9)  | set\_   | set functions: set\_template                | PASS   | 1 | 0.017 |
| [test-set.R](testthat/test-set.R#L14) | set\_   | set functions: set\_font\_family            | PASS   | 1 | 0.002 |
| [test-set.R](testthat/test-set.R#L19) | set\_   | set functions: set\_windows\_control\_theme | PASS   | 1 | 0.002 |
| [test-uri.R](testthat/test-uri.R#L10) | uri     | options: benchmark                          | PASS   | 1 | 0.007 |
| [test-uri.R](testthat/test-uri.R#L20) | uri     | uri: benchmark                              | PASS   | 1 | 0.002 |
| [test-uri.R](testthat/test-uri.R#L24) | uri     | uri: 200                                    | PASS   | 1 | 0.255 |
| [test-uri.R](testthat/test-uri.R#L32) | uri     | encode: encode character                    | PASS   | 1 | 0.002 |
| [test-uri.R](testthat/test-uri.R#L36) | uri     | encode: no encode character                 | PASS   | 1 | 0.002 |
| [test-uri.R](testthat/test-uri.R#L44) | uri     | tiny: valid tiny                            | PASS   | 1 | 0.489 |
| [test-uri.R](testthat/test-uri.R#L50) | uri     | tiny: clipboard                             | PASS   | 1 | 0.262 |
| [test-uri.R](testthat/test-uri.R#)    | uri     | bad template: error uri                     | PASS   | 1 | 0.003 |
| [test-yml.R](testthat/test-yml.R#L37) | yml     | yaml fields: rgba                           | PASS   | 1 | 0.006 |
| [test-yml.R](testthat/test-yml.R#L42) | yml     | yaml fields: template                       | PASS   | 1 | 0.002 |
| [test-yml.R](testthat/test-yml.R#L47) | yml     | yaml fields: bad font family                | PASS   | 1 | 0.002 |
| [test-yml.R](testthat/test-yml.R#L52) | yml     | yaml fields: pv                             | PASS   | 1 | 0.002 |
| [test-yml.R](testthat/test-yml.R#L57) | yml     | yaml fields: ph                             | PASS   | 1 | 0.002 |
| [test-yml.R](testthat/test-yml.R#L76) | yml     | namesless palette: fill in palette          | PASS   | 1 | 0.001 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                               |
| :------- | :---------------------------------- |
| Version  | R version 3.5.1 (2018-07-02)        |
| Platform | x86\_64-apple-darwin15.6.0 (64-bit) |
| Running  | macOS High Sierra 10.13.5           |
| Language | en\_US                              |
| Timezone | America/New\_York                   |

| Package  | Version |
| :------- | :------ |
| testthat | 2.0.0   |
| covr     | 3.1.0   |
| covrpage | 0.0.52  |

</details>

<!--- Final Status : pass --->
