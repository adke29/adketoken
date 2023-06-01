import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
actor Token{
  var owner :Principal = Principal.fromText("qoli5-zr26z-ph4pv-mcmnk-hlmru-zyhjw-pphk4-socqs-qx43f-dal7t-mqe");
  var totalSupply : Nat = 1000000000;
  var symbol:Text = "ADKE";

  var balances = HashMap.HashMap<Principal, Nat>(1,Principal.equal, Principal.hash);
  balances.put(owner,totalSupply);

  public query func balanceOf(who: Principal): async Nat{
    let balance:Nat = switch (balances.get(who)){
      case null 0;
      case (?result) result;
    };
    return balance;
  };

  public query func getSymbol():async Text{
    return symbol;
  }
}