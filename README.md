# EDB Operator Helm Chart

This Helm chart deploys the EDB Postgres for Kubernetes operator in OpenShift using Operator Lifecycle Manager (OLM).

## Prerequisites

- OpenShift cluster with OLM installed
- EDB operator available in the OperatorHub catalog
- Appropriate permissions to create namespaces, OperatorGroups, and Subscriptions

## Installation

### Basic Installation

```bash
helm install edb-operator ./helm-chart-edb-operator --namespace edb --create-namespace
```

### Custom Installation

```bash
helm install edb-operator ./helm-chart-edb-operator \
  --namespace edb \
  --create-namespace \
  --set operator.channel=v1 \
  --set operator.approval=Manual \
  --set operatorGroup.watchAllNamespaces=true
```

## Configuration

The following table lists the configurable parameters and their default values:

| Parameter | Description | Default |
|-----------|-------------|---------|
| `namespace.name` | Name of the namespace where the operator will be deployed | `edb` |
| `namespace.create` | Whether to create the namespace | `true` |
| `operator.name` | Name of the operator package | `edb-postgres-for-kubernetes` |
| `operator.channel` | Channel to subscribe to | `stable` |
| `operator.catalogSource` | Catalog source name | `redhat-operators` |
| `operator.catalogSourceNamespace` | Catalog source namespace | `openshift-marketplace` |
| `operator.approval` | Install plan approval strategy (`Automatic` or `Manual`) | `Automatic` |
| `operator.startingCSV` | Starting CSV version (optional) | `""` |
| `operatorGroup.name` | Name of the OperatorGroup | `edb-operator-group` |
| `operatorGroup.targetNamespaces` | List of target namespaces (empty means all) | `[]` |
| `operatorGroup.watchAllNamespaces` | Watch all namespaces | `false` |
| `subscription.name` | Name of the Subscription | `edb-postgres-for-kubernetes` |

## Usage

### Deploy to a specific namespace

```yaml
operatorGroup:
  targetNamespaces:
    - edb
    - production
```

### Deploy to watch all namespaces

```yaml
operatorGroup:
  watchAllNamespaces: true
```

### Use Manual approval for install plans

```yaml
operator:
  approval: Manual
```

## Verification

After installation, verify the operator is running:

```bash
# Check the subscription
oc get subscription -n edb

# Check the operator group
oc get operatorgroup -n edb

# Check the CSV (ClusterServiceVersion)
oc get csv -n edb

# Check the operator pods
oc get pods -n edb
```

## Uninstallation

To uninstall the chart:

```bash
helm uninstall edb-operator --namespace edb
```

Note: This will remove the Subscription, which will trigger the removal of the operator. The namespace will be removed if it was created by the chart.

## Troubleshooting

### Operator not appearing in OperatorHub

Ensure the EDB operator is available in your catalog source:

```bash
oc get packagemanifest -n openshift-marketplace | grep edb
```

### Subscription stuck in Installing state

Check the install plan:

```bash
oc get installplan -n edb
oc describe installplan <installplan-name> -n edb
```

### CSV not ready

Check the CSV status:

```bash
oc get csv -n edb
oc describe csv <csv-name> -n edb
```
