# Allow custom tags via a define
define datadog_agent::tag(
  $tag = $name,
  $lookup_fact = false,
){

  if $lookup_fact{
    $value = getvar($tag)
    if $value =~ Array {
      datadog_agent::tag{$value.map |$v| { "$tag:$v" }: }
    }
    concat::fragment{ "datadog tag ${tag}:${value}":
      target  => '/etc/dd-agent/datadog.conf',
      content => "${tag}:${value}, ",
      order   => '03',
    }
  } else {
    concat::fragment{ "datadog tag ${tag}":
      target  => '/etc/dd-agent/datadog.conf',
      content => "${tag}, ",
      order   => '03',
    }
  }

}
