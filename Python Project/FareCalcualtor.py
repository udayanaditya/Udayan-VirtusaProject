# Dictionary for Vehicle type and its fair
rates={
    "Economy" : 10,
    "Premium" : 18,
    "SUV" : 25
}

# Function to Calculate the fare
def calculate_fare(km , type ,hour):

    # Check if type exists
    try:
        if type not in rates:
            return None
        baseRate= rates[type] 
        baseFare= km * baseRate

        # Applying Surge charge
        if 17<= hour <=20:
            surge=1.5
        else:
            surge=1
        totalFare= baseFare * surge
        return totalFare
    except Exception as e:
        print("Error:",e)
        return None

# Handling user input
try:
    km= float(input("Enter the distance in kilometers:"))
    type=input("Enter vehicle type (Economy/Premium/SUV): ")
    hour=int(input("Enter hour of travel(0 to 23):")) 
    fare= calculate_fare(km,type,hour)

    #Output Reciept
    print("\n Price Receipt: ")

    if fare is None:
        print("Vehicle Type not available")
    else:
        print(f"Distance Travelled : {km} km")    
        print(f"Vehicle Type       : {type}")
        print(f"Base Rate (/km)    : ₹{rates[type]}")

        if 17<= hour <=20:
            print("Surge Pricing : Applied(1.5x)")
        else:
            print("Surge Pricing : Not Applied")  

        print(f"Ride Estimate : Rs {fare:.2f}")
except ValueError:
    print("Error! Please enter correct values")              