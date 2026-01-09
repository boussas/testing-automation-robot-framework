# Testing automation using Robot framework

Automated end-to-end tests for the Sauce Demo web app using Robot Framework and SeleniumLibrary.

## Summary
This repository contains Robot Framework tests that validate login and cart behavior on https://www.saucedemo.com. 

Tests run with SeleniumLibrary (Chrome) and produce Robot Framework results in the `results/` folder. 

A helper `publish.sh` script uploads results to Xray (Jira) if configured.

## Features
- Login tests (valid/invalid credentials)
- Cart tests (add-to-cart, cart contents, badge count)
- Results: HTML report and JUnit/XML outputs
- Optional: publish results to Xray via `publish.sh`

## Prerequisites
- Linux / macOS / Windows with Chrome installed
- Python 3.8+
- ChromeDriver compatible with your Chrome version (or use a WebDriver manager)
- Robot Framework and SeleniumLibrary
