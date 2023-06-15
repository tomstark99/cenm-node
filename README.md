# cenm-node

This branch provides default config for using a Corda node with Gemalto Luna HSM

## Usage

The `node.conf` file has been modified to add crypto service conf for the identity key and the confidential identities key:

```properties
cryptoServiceName = "GEMALTO_LUNA"
cryptoServiceConf = "./gemalto/gemalto_12.conf"
cryptoServiceTimeout = "60s"
enterpriseConfiguration {
    identityKeyAlias = "node-identity-key-<PLEASE_REPLACE>"
    clientCaKeyAlias = "node-ca-ppe-<PLEASE_REPLACE>"
}
```

and

```properties
freshIdentitiesConfiguration {
    mode = "WRAPPED"
    cryptoServiceConfiguration {
       cryptoServiceName = "GEMALTO_LUNA"
       cryptoServiceConf = "./gemalto/gemalto_11.conf"
    }
    masterKeyAlias = "node-key-ppe-<PLEASE_REPLACE>"
}
```

## Changing key partitions

By default the config is set for multi-partition use (which will only work with Corda `4.9.7+/4.10.2+`)

Each `gemalto_xx.conf` file has two numbers:

- The first number indicates the HSM the keys are stored on (aka HSM1 or HSM2)
- The second number indicates the partition the keys are stored in on that HSM:
    - Partition 1: Wrapped mode
    - Partition 2: Cloning mode

In the example above, the identity key would be stored in `hsm1par2` and the confidential identities key would be stored in `hsm1par1`

Feel free to set this however you require (The same partition can be used for both e.g. if using an older version of Corda that does not support multi-partition key storing).

## Using keystores

These are named in the same way as the gemalto config files and can be used to check the contents of a partition when using the Java `keytool`.