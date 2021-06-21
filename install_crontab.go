package main

import(
    "io/ioutil"
    "strings"
    "strconv"
)

func main() {
    var crontab []byte
    var hours []byte
    var hourStr string
    var hourInt int

    crontab, _ = ioutil.ReadFile("./crontab_template")
    hours, _ = ioutil.ReadFile("./hours.txt")
    hourStr = string(hours)
    hourStr = strings.Replace(hourStr, "\n", "", -1)
    hourInt, _ = strconv.Atoi(hourStr)

    if hourInt == 0 {
        hourStr = "23"
    } else {
        hourStr = strconv.Itoa(hourInt - 1)
    }

    ioutil.WriteFile("./hours.txt", []byte(hourStr), 0777)
    ioutil.WriteFile("etc/crontab", []byte(string(crontab) + "0 " + hourStr + " * * * ~/crontab/glados/signin.sh > ~/crontab/glados/run.log 2>&1\n"), 0644)
}
