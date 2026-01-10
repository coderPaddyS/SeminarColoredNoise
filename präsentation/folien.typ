#import "kitslides.typ": *

#show: it => KITSlides(
  it
)

#normal-slide[
#new-section("First section")
= Test 1
Test
]
#normal-slide[
= Test 2
Test
]
#normal-slide[
= Test 3
#only(2)[Ha]
Test
]

#normal-slide[
#new-section("Second section")
= 2. Test 4
Test
]

#normal-slide[
#only(1,new-section("Third section"))
#only(2)[Ha]
= 3. Test 5
Test
]

#normal-slide[
= 3. Test 6
#only(2)[Ha]
Test
]

#normal-slide[
#new-section("Fourth section")
= 4. Test 7
Test
]

#normal-slide[
#new-section("Fifth section")
= 5.. Test 5
Test
]