import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  stable var currentValue: Float = 300;
  currentValue := 300;
  Debug.print(debug_show(currentValue));

  stable var startTime = Time.now();
  startTime := Time.now();
  Debug.print(debug_show(startTime));
 
  let id = 20004056;
  // Debug.print(debug_show(id));

  public func topUp(amount: Float) {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };
  // Allow users to withdraw an amount from the currentValue
  // Decrease the currentValue by the amount

  public func withdraw(amount: Float) {
    let tempValue: Float = currentValue - amount;
    if (tempValue >= 0) {
    currentValue -= amount;
    Debug.print(debug_show(currentValue));
    } else {
      Debug.print("You can't withdraw more than the current Value!")
    }
  };
  // query and update functions => query doesn't go through the blockchain
  // updates go through the blockchain, hence they take longer
  // use query to read from your app to save tiem and gas efficiency

  public query func checkBalance(): async Float {
    return currentValue;

  };

  public func compound() {
    let currentTime = Time.now();
    let timeElapsed = (currentTime - startTime) / 1000000000; /*we're dividing by 1e9 because we're converting from nanosecondvto seconds*/
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsed));
    startTime := currentTime;
  }
}