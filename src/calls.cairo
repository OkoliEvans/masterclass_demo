#[starknet::contract]
mod ContractCalls {
    use core::option::OptionTrait;
use core::traits::TryInto;
use project::abc::{IERC20Dispatcher, IERC20DispatcherTrait, IERC20LibraryDispatcher };
use starknet::{ ContractAddress, class_hash, ClassHash};
    #[storage]
    struct Storage {
        val: u256
    }

    #[abi(embed_v0)]
    fn transfer(ref self: ContractState, to: starknet::ContractAddress, amount: u256) {
        let address = 1234.try_into().unwrap();
        IERC20Dispatcher { contract_address: address }.transfer(to, amount);
    }

    fn transfer_fake_money(ref self: ContractState, class_hash: ClassHash, to: ContractAddress, amount: u256) {
        IERC20LibraryDispatcher { class_hash}.transfer(to, amount);
    }

}