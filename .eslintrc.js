module.exports = {
    "env": {
        "browser": true,
        "es6": true
    },
    "extends": "eslint:recommended",
    "globals": {
        "Atomics": "readonly",
        "SharedArrayBuffer": "readonly"
    },
    "parserOptions": {
        "ecmaVersion": 2018,
        "sourceType": "module"
    },
    "rules": {
        "linebreak-style": [
            "error",
            "unix"
        ],
        "no-console": 1,
        "quotes": [
          "error",
          "single"
        ],
        "semi": "error",
        "semi-spacing": "error",
        "semi-style": [
            "error",
            "last"
        ]
    }
};
