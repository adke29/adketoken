import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";
actor Token {
  var owner : Principal = Principal.fromText("qoli5-zr26z-ph4pv-mcmnk-hlmru-zyhjw-pphk4-socqs-qx43f-dal7t-mqe");
  var totalSupply : Nat = 1000000000;
  var symbol : Text = "ADKE";

  var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
  balances.put(owner, totalSupply);

  public query func balanceOf(who : Principal) : async Nat {
    let balance : Nat = switch (balances.get(who)) {
      case null 0;
      case (?result) result;
    };
    return balance;
  };

  public query func getSymbol() : async Text {
    return symbol;
  };

  public shared(msg) func payOut():async Text{
    if(balances.get(msg.caller) == null){
        let amount = 1000;
        balances.put(msg.caller,amount);
        return "Success";
    }else{
      return "You have claimed before!!";
    }
  };

  public shared(msg) func transfer(to: Principal, amount: Nat):async Text{
    let fromBalance:Nat = await balanceOf(msg.caller);
    if(fromBalance >= amount){
      let toBalance:Nat = await balanceOf(to);
      balances.put(msg.caller, fromBalance - amount);
      balances.put(to, toBalance + amount);
      return "Transfer Success";
    }else{
      return "Insufficient Balance";
    }
  }

};
