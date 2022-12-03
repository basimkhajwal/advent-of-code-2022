#! /bin/bash
set -euo pipefail

file=${1:-input/day02.txt}

function part1 {
  score=0
  while read -r line; do
    ins=($line)
    (( score += ins[1] + 1 ))
    (( score += ins[0] == ins[1] ? 3 : 0 ))
    (( score += (ins[0] + 1) % 3 == ins[1] ? 6 : 0 ))
  done < <(cat $file | tr ABCXYZ 012012)
  echo $score
}

function part2 {
  score=0
  while read -r line; do
    ins=($line)
    (( score += 1+(ins[0]+ins[1]+2)%3 + 3*ins[1] ))
  done < <(cat $file | tr ABCXYZ 012012)
  echo $score
}

part1
part2
