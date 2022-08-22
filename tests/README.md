Tests and Coverage
================
21 August, 2022 21:08:08

-   <a href="#coverage" id="toc-coverage">Coverage</a>
-   <a href="#unit-tests" id="toc-unit-tests">Unit Tests</a>

This output is created by
[covrpage](https://github.com/yonicd/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                              | Coverage (%) |
|:----------------------------------------------------|:------------:|
| carbonate                                           |    48.04     |
| [R/addins.R](../R/addins.R)                         |     0.00     |
| [R/carbonate.R](../R/carbonate.R)                   |     0.00     |
| [R/selenium_functions.R](../R/selenium_functions.R) |    20.00     |
| [R/uri_functions.R](../R/uri_functions.R)           |    38.60     |
| [R/carbon.R](../R/carbon.R)                         |    60.61     |
| [R/helpers.R](../R/helpers.R)                       |    76.64     |
| [R/set_get_functions.R](../R/set_get_functions.R)   |    100.00    |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                |   n |  time | error | failed | skipped | warning | icon |
|:------------------------------------|----:|------:|------:|-------:|--------:|--------:|:-----|
| [test-port.R](testthat/test-port.R) |   3 | 0.044 |     0 |      0 |       0 |       0 |      |
| [test-set.R](testthat/test-set.R)   |   3 | 0.953 |     0 |      0 |       0 |       0 |      |
| [test-uri.R](testthat/test-uri.R)   |   8 | 1.662 |     0 |      0 |       2 |       0 | 🔶   |
| [test-yml.R](testthat/test-yml.R)   |   6 | 2.619 |     0 |      0 |       0 |       0 |      |

<details open>
<summary>
Show Detailed Test Results
</summary>

| file                                    | context | test                                     | status  |   n |  time | icon |
|:----------------------------------------|:--------|:-----------------------------------------|:--------|----:|------:|:-----|
| [test-port.R](testthat/test-port.R#L9)  | port    | port: init                               | PASS    |   1 | 0.033 |      |
| [test-port.R](testthat/test-port.R#L14) | port    | port: reset                              | PASS    |   1 | 0.009 |      |
| [test-port.R](testthat/test-port.R#L19) | port    | port: manual                             | PASS    |   1 | 0.002 |      |
| [test-set.R](testthat/test-set.R#L8)    | set\_   | set functions: set_template              | PASS    |   1 | 0.585 |      |
| [test-set.R](testthat/test-set.R#L13)   | set\_   | set functions: set_font_family           | PASS    |   1 | 0.366 |      |
| [test-set.R](testthat/test-set.R#L18)   | set\_   | set functions: set_windows_control_theme | PASS    |   1 | 0.002 |      |
| [test-uri.R](testthat/test-uri.R#L9)    | uri     | options: benchmark                       | PASS    |   1 | 0.238 |      |
| [test-uri.R](testthat/test-uri.R#L17)   | uri     | uri: benchmark                           | PASS    |   1 | 0.245 |      |
| [test-uri.R](testthat/test-uri.R#L21)   | uri     | uri: 200                                 | PASS    |   1 | 0.878 |      |
| [test-uri.R](testthat/test-uri.R#L27)   | uri     | encode: encode character                 | PASS    |   1 | 0.003 |      |
| [test-uri.R](testthat/test-uri.R#L31)   | uri     | encode: no encode character              | PASS    |   1 | 0.002 |      |
| [test-uri.R](testthat/test-uri.R#L37)   | uri     | tiny: valid tiny                         | SKIPPED |   1 | 0.014 | 🔶   |
| [test-uri.R](testthat/test-uri.R#L43)   | uri     | tiny: clipboard                          | SKIPPED |   1 | 0.015 | 🔶   |
| [test-uri.R](testthat/test-uri.R#)      | uri     | bad template: error uri                  | PASS    |   1 | 0.267 |      |
| [test-yml.R](testthat/test-yml.R#L24)   | yml     | yaml fields: rgba                        | PASS    |   1 | 0.526 |      |
| [test-yml.R](testthat/test-yml.R#L29)   | yml     | yaml fields: template                    | PASS    |   1 | 0.420 |      |
| [test-yml.R](testthat/test-yml.R#L34)   | yml     | yaml fields: bad font family             | PASS    |   1 | 0.543 |      |
| [test-yml.R](testthat/test-yml.R#L39)   | yml     | yaml fields: pv                          | PASS    |   1 | 0.530 |      |
| [test-yml.R](testthat/test-yml.R#L44)   | yml     | yaml fields: ph                          | PASS    |   1 | 0.598 |      |
| [test-yml.R](testthat/test-yml.R#L59)   | yml     | namesless palette: fill in palette       | PASS    |   1 | 0.002 |      |

| Failed | Warning | Skipped |
|:-------|:--------|:--------|
| 🛑     | ⚠️      | 🔶      |

</details>
<details>
<summary>
Session Info
</summary>

| Field    | Value                            |
|:---------|:---------------------------------|
| Version  | R version 4.2.1 (2022-06-23)     |
| Platform | x86_64-apple-darwin17.0 (64-bit) |
| Running  | macOS Big Sur 11.6               |
| Language | en_US                            |
| Timezone | America/New_York                 |

| Package  | Version |
|:---------|:--------|
| testthat | 3.1.4   |
| covr     | 3.5.1   |
| covrpage | 0.1     |

</details>
<!--- Final Status : skipped/warning --->
