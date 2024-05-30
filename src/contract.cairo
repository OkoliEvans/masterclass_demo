#[starknet::contract]
mod ERC20 {
    use core::starknet::event::EventEmitter;
use project::abc::{IERC20, IERC20Dispatcher, IERC20DispatcherTrait};
    use starknet::{ContractAddress, get_caller_address, get_contract_address};

    #[storage]
    struct Storage {
        balance: LegacyMap<ContractAddress, u256>,
        allowance: u256,
        owner: ContractAddress
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        Transferred: Transferred,
        Allowance: Allowance,
    }

    #[derive(Drop, starknet::Event)]
    struct Transferred {
        sender: ContractAddress,
        receiver: ContractAddress,
        amount: u256,
    }

    #[derive(Drop, starknet::Event)]
    struct Allowance {
        owner: ContractAddress,
        spender: ContractAddress,
        amount: u256,
    }

    #[constructor]
    fn constructor(ref self: ContractState, owner: ContractAddress) {
        self.owner.write(owner);
    }

    #[abi(embed_v0)]
    impl IERC20Trait of IERC20<ContractState> {
        fn transfer(ref self: ContractState, to: starknet::ContractAddress, amount: u256) {
            self._transfer(to, amount);
        }

        fn transfer_from(
            ref self: ContractState, from: ContractAddress, to: ContractAddress, amount: u256
        ) {}
    }

    #[generate_trait]
    impl Private of PrivateTrait {
        fn _transfer(ref self: ContractState, receiver: ContractAddress, amount: u256) {
            let sender = self.owner.read();
            let caller: ContractAddress = get_caller_address();
            assert!(caller == sender, "Not owner");
            self.balance.write(receiver, self.balance.read(receiver) + amount);
            self.balance.write(caller, self.balance.read(caller) - amount);
            self.emit(Transferred {sender, receiver, amount} );
        }
    }
}
