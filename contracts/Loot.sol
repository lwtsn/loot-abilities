// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LootClassAbilities is ERC721Enumerable, ReentrancyGuard, Ownable {
    ERC721 loot = ERC721(0xFF9C1b15B16263C61d017ee9F65C50e4AE0113D7);

    mapping(uint256 => Class) classMapping;

    struct Class {
        string name;
        string[7] basicSkills;
        string[3] ultimateSkills;
        uint8 position;
    }

    uint256 classCount = 14;

    Class barbarian = Class({
    position : 0,
    name : "Barbarian",
    basicSkills : [
        "Reckless Attack",
        "Brutal Critical",
        "Intimidating Presence",
        "Primal Rage",
        "Feral Instinct",
        "Frenzy",
        "Sever Artery"
        ],
    ultimateSkills : [
        "Berserk Fury",
        "Unrelenting Rage",
        "Unbreakable Stance"
        ]
    });

    Class bard = Class({
    position : 1,
    name : "Bard",
    basicSkills : [
        "Imitating Cry",
        "Charm Person",
        "Sense Thoughts",
        "Inspring Chant",
        "Song of Healing",
        "Distracting Ballad",
        "Calming Melody"
        ],
    ultimateSkills : [
        "Healing Song",
        "Enraging Melody",
        "Song of Trickery"
        ]
    });

    Class cleric = Class({
    position : 2,
    name : "Cleric",
    basicSkills : [
        "Blinding Light",
        "Sense Evil",
        "Holy Water",
        "Remove Curse",
        "Burning Luminescence",
        "Regenerate",
        "Purify"
        ],
    ultimateSkills : [
        "Healing Prayer",
        "Divine Sense",
        "Shield of Faith"
        ]
    });

    Class druid = Class({
    position : 3,
    name : "Druid",
    basicSkills : [
        "Summon Dire Wolf",
        "Natural Healing",
        "Imbue Potion",
        "Locate Creature",
        "Nature's Ward",
        "Web of Spider",
        "Pacify Beast"
        ],
    ultimateSkills : [
        "Plague of Insects",
        "Vine Entanglement",
        "Unrelenting Rain"
        ]
    });

    Class fighter = Class({
    position : 4,
    name : "Fighter",
    basicSkills : [
        "Brutual Strike",
        "Disrupting Blow",
        "Counter Attack",
        "Heal Wound",
        "Patient Defense",
        "Double Strike",
        "Dismember"
        ],
    ultimateSkills : [
        "Anthem of Fury",
        "Diamond Skin",
        "Strike of a Hundred Blades"
        ]
    });

    Class monk = Class({
    position : 5,
    name : "Monk",
    basicSkills : [
        "Purity of Body",
        "Heal Party",
        "Healing Touch",
        "Holy Strike",
        "Ring of Warding",
        "Seed of Life",
        "Banish Foe"
        ],
    ultimateSkills : [
        "Restore Life",
        "Holy Aura",
        "Bless Water"
        ]
    });

    Class paladin = Class({
    position : 6,
    name : "Paladin",
    basicSkills : [
        "Guided Strike",
        "Hand of God",
        "Heal Wounds",
        "Sacred Oath",
        "Aura of Protection",
        "Call Lightning",
        "Maelstrom"
        ],
    ultimateSkills : [
        "Resurrect",
        "Divine Intervention",
        "Purification"
        ]
    });

    Class ranger = Class({
    position : 7,
    name : "Ranger",
    basicSkills : [
        "Flaming Arrow",
        "Eagle Eye",
        "Dual Shot",
        "Keen Ear",
        "True Shot",
        "Quick Shot",
        "Dodge Attack"
        ],
    ultimateSkills : [
        "Rain of Arrows",
        "Track Foe",
        "Giant Slayer"
        ]
    });

    Class rogue = Class({
    position : 8,
    name : "Rogue",
    basicSkills : [
        "Evade Attack",
        "Back Stab",
        "Pick Pocket",
        "Dash",
        "Fast",
        "Trick Shot",
        "Blinding Powder"
        ],
    ultimateSkills : [
        "Cheat Death",
        "Crack Lock",
        "Hide in the Shadows"
        ]
    });

    Class sorcerer = Class({
    position : 9,
    name : "Sorcerer",
    basicSkills : [
        "Arcane Might",
        "Eruption",
        "Phoenix Fire",
        "Ancestral Wisdom",
        "Earth Shake",
        "Greater Wisdom",
        "Mending"
        ],
    ultimateSkills : [
        "Flame of the Dragon",
        "Elemental Lord",
        "Animate Object"
        ]
    });

    Class warlock = Class({
    position : 10,
    name : "Warlock",
    basicSkills : [
        "Mark of Blood",
        "Soul Grasp",
        "Raise Minion",
        "Consume Flesh",
        "Summon Undead",
        "Repel Dead",
        "Armour of Shadows"
        ],
    ultimateSkills : [
        "Summon Demon",
        "Devil's Sight",
        "Chaotic Undoing"
        ]
    });

    Class wizard = Class({
    position : 11,
    name : "Wizard",
    basicSkills : [
        "Fireball",
        "Invisibility",
        "Metamorphosis",
        "Flame Shock",
        "Gift of Foresight",
        "Frost Nova",
        "Ice Chains"
        ],
    ultimateSkills : [
        "Meteoric Shower",
        "Armour of Earth",
        "Immolate Foe"
        ]
    });

    //generating a random number
    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function getUltimateSkill(uint256 tokenId) public view returns (string memory) {
        return pluckUltimateSkill(tokenId, classMapping[pluckClass(tokenId, "Class")].ultimateSkills);
    }

    function getFirstSkill(uint256 tokenId) public view returns (string memory) {
        return pluckSkill(tokenId, classMapping[pluckClass(tokenId, "Class")].basicSkills, "FirstSkill");
    }

    function getClass(uint256 tokenId) public view returns (string memory) {
        return classMapping[pluckClass(tokenId, "Class")].name;
    }

    function pluckClass(uint256 tokenId, string memory keyPrefix) internal view returns (uint256) {
        uint256 rand = random(string(abi.encodePacked(keyPrefix, toString(tokenId))));
        return classMapping[rand % classCount].position;
    }

    function pluckSkill(uint256 tokenId, string[7] memory skills, string memory keyPrefix) internal pure returns (string memory) {
        uint256 rand = random(string(abi.encodePacked(keyPrefix, toString(tokenId))));
        string memory output = skills[rand % skills.length];
        output = string(abi.encodePacked(output));

        return output;
    }

    function pluckUltimateSkill(uint256 tokenId, string[3] memory skills) internal pure returns (string memory) {
        string memory keyPrefix = "ULTIMATE_SKILL";
        uint256 rand = random(string(abi.encodePacked(keyPrefix, toString(tokenId))));
        string memory output = skills[rand % skills.length];
        output = string(abi.encodePacked(output));

        return output;
    }

    function tokenURI(uint256 tokenId) override public view returns (string memory) {
        string[7] memory parts;
        parts[0] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="black" /><text x="10" y="20" class="base">';

        parts[1] = getClass(tokenId);

        parts[2] = '</text><text x="10" y="40" class="base">';

        parts[3] = getUltimateSkill(tokenId);

        parts[4] = '</text><text x="10" y="60" class="base">';

        parts[5] = getFirstSkill(tokenId);

        parts[6] = '</text></svg>';

        string memory output = string(abi.encodePacked(
                parts[0],
                parts[1],
                parts[2],
                parts[3],
                parts[4],
                parts[5],
                parts[6]
            ));

        string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "Sheet #', toString(tokenId), '", "description": "Loot Class are randomized RPG style classes generated and stored on chain. Feel free to use Loot Class in any way you want.", "image": "data:image/svg+xml;base64,', Base64.encode(bytes(output)), '"}'))));
        output = string(abi.encodePacked('data:application/json;base64,', json));

        return output;
    }

    function claim(uint256 tokenId) public nonReentrant {
        require(tokenId > 8000 && tokenId < 9576, "Token ID invalid");
        _safeMint(_msgSender(), tokenId);
    }

    function claimForLoot(uint256 tokenId) public nonReentrant {
        require(tokenId > 0 && tokenId < 8001, "Token ID invalid");
        require(loot.ownerOf(tokenId) == msg.sender, "Not Loot owner");
        _safeMint(_msgSender(), tokenId);
    }

    function ownerClaim(uint256 tokenId) public nonReentrant onlyOwner {
        require(tokenId > 9575 && tokenId < 10001, "Token ID invalid");
        _safeMint(owner(), tokenId);
    }

    function toString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT license
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    constructor() ERC721("Loot Class Abilities", "CLASS_ABILITIES") Ownable() {
        classMapping[barbarian.position] = barbarian;
        classMapping[bard.position] = bard;
        classMapping[cleric.position] = cleric;
        classMapping[druid.position] = druid;
        classMapping[fighter.position] = fighter;
        classMapping[monk.position] = monk;
        classMapping[paladin.position] = paladin;
        classMapping[ranger.position] = ranger;
        classMapping[rogue.position] = rogue;
        classMapping[sorcerer.position] = sorcerer;
        classMapping[warlock.position] = warlock;
        classMapping[wizard.position] = wizard;
    }
}


/// [MIT License]
/// @title Base64
/// @notice Provides a function for encoding some bytes in base64
/// @author Brecht Devos <brecht@loopring.org>
library Base64 {
    bytes internal constant TABLE = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    /// @notice Encodes some bytes to the base64 representation
    function encode(bytes memory data) internal pure returns (string memory) {
        uint256 len = data.length;
        if (len == 0) return "";

        // multiply by 4/3 rounded up
        uint256 encodedLen = 4 * ((len + 2) / 3);

        // Add some extra buffer at the end
        bytes memory result = new bytes(encodedLen + 32);

        bytes memory table = TABLE;

        assembly {
            let tablePtr := add(table, 1)
            let resultPtr := add(result, 32)

            for {
                let i := 0
            } lt(i, len) {

            } {
                i := add(i, 3)
                let input := and(mload(add(data, i)), 0xffffff)

                let out := mload(add(tablePtr, and(shr(18, input), 0x3F)))
                out := shl(8, out)
                out := add(out, and(mload(add(tablePtr, and(shr(12, input), 0x3F))), 0xFF))
                out := shl(8, out)
                out := add(out, and(mload(add(tablePtr, and(shr(6, input), 0x3F))), 0xFF))
                out := shl(8, out)
                out := add(out, and(mload(add(tablePtr, and(input, 0x3F))), 0xFF))
                out := shl(224, out)

                mstore(resultPtr, out)

                resultPtr := add(resultPtr, 4)
            }

            switch mod(len, 3)
            case 1 {
                mstore(sub(resultPtr, 2), shl(240, 0x3d3d))
            }
            case 2 {
                mstore(sub(resultPtr, 1), shl(248, 0x3d))
            }

            mstore(result, encodedLen)
        }

        return string(result);
    }
}
