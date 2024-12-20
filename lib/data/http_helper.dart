// import 'dart:html';
// import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'trend_result.dart';

class HttpHelper {
  // http://api.openweathermap.org/data/2.5/weather?q={city name}&appid=ca9091c775fcff0f1d8af14f4bd1c815

  // final String authority = 'api.openweathermap.org';
  // final String path = 'data/2.5/weather';
  // final String apiKey = 'ca9091c775fcff0f1d8af14f4bd1c815';

  final String authority = 'http://localhost:3000/';
  final String path = 'v2/widgets/standard/preview';

  Future<TrendData> getDashboardData() async {
    String authToken =
        'AUTH_TOKEN=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOlsiYXBpLmRhdGEudm13c2VydmljZXMuY29tIl0sInN1YiI6IjE3ZTJhZDFhLWM5ZDktNDJkYS1iNWM1LWRhODc5NDY1ZDM2NCIsIm5iZiI6MTYzNzIwMDc2NSwidm13YXJlLmRpc3BsYXlfbmFtZSI6InR3ZWlAdm13YXJlLmNvbSIsInZtd2FyZS5jbGllbnRfaWQiOiIxN2UyYWQxYS1jOWQ5LTQyZGEtYjVjNS1kYTg3OTQ2NWQzNjQiLCJzY29wZSI6WyJkcGEuYmxhbnRvbnMuZXVsYSIsImRwYS5ibGFudG9ucy5mZWRlcmF0aW9uLnNldHRpbmdzIiwiZHBhLmJsYW50b25zLmludGVncmF0aW9uLnJlZ2lzdHJhdGlvbiIsImRwYS5ibGFudG9ucy5vcmcucmVnaXN0cmF0aW9uIiwiZHBhLmJsYW50b25zLnRlbmFudC5wcm92aXNpb24ucmVhZG9ubHkiLCJkcGEuYnV6emtpbGwuc2VydmljZWxpbWl0IiwiZHBhLmRheXRpbWUuYWRtaW4uZGFzaGJvYXJkIiwiZHBhLmRheXRpbWUuZGFzaGJvYXJkIiwiZHBhLmRheXRpbWUuc2V0dGluZ3MuZGFzaGJvYXJkIiwiZHBhLmZpcmViYWxsLmNyYXNoLmRlYnVnZmlsZSIsImRwYS5mb3JjZW9md2lsbC5hZG1pbi5yZXBvcnQiLCJkcGEuZm9yY2VvZndpbGwucmVwb3J0IiwiZHBhLmZvcmNlb2Z3aWxsLnNldHRpbmdzLnJlcG9ydC5yZWFkb25seSIsImRwYS5mb3JjZW9md2lsbC50ZW1wbGF0ZS5yZXBvcnQiLCJkcGEuZm9yY2VvZndpbGwudXNlcnMiLCJkcGEuZ2FuZ3N0ZXIuYWNjb3VudCIsImRwYS5nYW5nc3Rlci5kaXJlY3RvcnkiLCJkcGEuZ2FuZ3N0ZXIuZGlyZWN0b3J5Z3JvdXAiLCJkcGEuZ2xlbmZpZGRpY2guaW50ZWdyYXRpb25hY3Rpb25zIiwiZHBhLmdsZW5maWRkaWNoLmludGVncmF0aW9ub2JqZWN0cyIsImRwYS5nbGVuZmlkZGljaC5zdGF0aXN0aWNzIiwiZHBhLmtyb25lbmJvdXJnLnBhcnRuZXIiLCJkcGEubWVybG90LmFwcHJlZ2lzdHJhdGlvbiIsImRwYS5tZXJsb3QuZGFzaGJvYXJkLndpZGdldCIsImRwYS5tZXJsb3QuZW50aXR5X21ldHJpY3MucmVhZG9ubHkiLCJkcGEubWVybG90LmVudGl0eXRocmVzaG9sZHMiLCJkcGEubWVybG90LmludGVncmF0aW9uIiwiZHBhLm1lcmxvdC5yZXBvcnQiLCJkcGEubWVybG90LnJpc2tzY29yZSIsImRwYS5tZXJsb3Quc29sdXRpb25fc2V0dGluZyIsImRwYS5tZXJsb3QudXNlcnMiLCJkcGEucG9wcXVpei5zdXJ2ZXkiLCJkcGEucHJhbnFzdGVyLmRhdGFhY2Nlc3Nwb2xpY3kiLCJkcGEucHJhbnFzdGVyLmlhbS5hY2NvdW50IiwiZHBhLnByYW5xc3Rlci5pYW0uYWNjb3VudGdyb3VwIiwiZHBhLnByYW5xc3Rlci5pYW0uaW50ZWdyYXRpb24iLCJkcGEucHJhbnFzdGVyLm9hdXRoY2xpZW50IiwiZHBhLnByYW5xc3Rlci5wYXJ0bmVyIiwiZHBhLnNjb2ZmbGF3LmFsZXJ0IiwiZHBhLnNjb2ZmbGF3LmluY2lkZW50IiwiZHBhLnNjb2ZmbGF3Lmluc2lnaHQiLCJkcGEuc2N1bHBpbi5tZXRhZGF0YS5yZWFkb25seSIsImRwYS5zd2VldHdhdGVyLnNldHRpbmdzIiwiZHBhLnN3ZWV0d2F0ZXIud29ya2Zsb3ciXSwiaXNzIjoiaHR0cHM6Ly9hdXRoLnN0YWdpbmcuZHBhMC5vcmciLCJ2bXdhcmUub3JnX2lkIjoiNTM4ZjYxOWUtMmRiNC00ZjA3LTk3NGItZWZiM2U1MzI2MTE2IiwiZXhwIjoxNjM3MjE1NDY1LCJqdGkiOiIzZGIwZDAzZi0wZTA2LTRmY2QtOTg2Ny0yN2ZmM2JmZTE3MGYiLCJ2bXdhcmUucm9sZSI6WyJmOWQ3N2UwMi00OTU0LTQ2N2ItODExZC1kYWYwYjU5YWJjM2EiLCJkY2QwOTc0Ny1jMzIyLTRhNzYtYTcxNi1iZjliMTQyNjc5NjEiLCJiZmVjNzQ4OS1iNTI3LTQ3MWEtOWFkOC1lYmIzODdkYjg3YzIiLCI3OTI4YmRmYi0zZDcwLTRiZjQtYWNiOC0xZThkYzg3NjI5NTgiXX0.JHJ3NIdag4QLqzrFHruJGYfo56aVhOGKfLw75XwKCSNE8p6iL6sH2t9DfSCp9o-zbrYOlArj46Soyju1zQyMbnsK4XWAQItzpQ2ZkQQb4hVvW3BeclbWNAtksff9mGAmZyVcp0h0N7eCmfSi-TpJ9MzWPWwIr5wIB-x0v7WZZoz7Eut-WEQzO-2j9MsPPZapB-iDH5TdBDDuv9KVnlV38dLBxiXTVXsMyYQMhgD0cLETHtfL6dKs32DPVVcW_h__iv-RrUsd4gAOwFBmvE_ADTHn1joSdydz26i0ysqvg0iuw6B28aVFJFWd2nfTRoPdseeK-0AulNLR4avYsQA_cA;';
    Object body = {
      "HORIZON_TOTAL_LOCATION_COUNT": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.pod.location",
            "aggregation_function": "COUNT_DISTINCT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["pod"]
        },
        "filter": "horizon.pod.adp_modified_at WITHIN 24 HOURS",
        "cardinality": 30
      },
      "HORIZON_TOTAL_DEPLOYMENT_COUNT": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.pod._deployment_type",
            "aggregation_function": "COUNT_DISTINCT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["pod"]
        },
        "filter": "horizon.pod.adp_modified_at WITHIN 24 HOURS",
        "cardinality": 30
      },
      "HORIZON_TOTAL_POD_COUNT": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.pod.pod_name",
            "aggregation_function": "COUNT_DISTINCT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["pod"]
        },
        "filter": "horizon.pod.adp_modified_at WITHIN 24 HOURS",
        "cardinality": 30
      },
      "HORIZON_TOTAL_POOL_COUNT": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.pool.pool_uid",
            "aggregation_function": "COUNT_DISTINCT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["pool"]
        },
        "filter": "horizon.pool.adp_modified_at WITHIN 24 HOURS",
        "cardinality": 30
      },
      "HORIZON_CPU_UTILIZATION_FOR_VMWARE_SDDC_PODS": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "bucketing_attributes": ["horizon.pod._deployment_type"],
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.pod.cpu_used_percent",
            "aggregation_function": "AVG"
          }
        ],
        "entities_by_integration": {
          "horizon": ["pod"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.pod.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_MEMORY_UTILIZATION_FOR_VMWARE_SDDC_PODS": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "bucketing_attributes": ["horizon.pod._deployment_type"],
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.pod.mem_used_percent",
            "aggregation_function": "AVG"
          }
        ],
        "entities_by_integration": {
          "horizon": ["pod"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.pod.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_DISK_UTILIZATION_FOR_VMWARE_SDDC_PODS": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "bucketing_attributes": ["horizon.pod._deployment_type"],
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.pod.disk_used_percent",
            "aggregation_function": "AVG"
          }
        ],
        "entities_by_integration": {
          "horizon": ["pod"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.pod.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_DESKTOP_SESSION_UTILIZATION_FOR_AZURE_PODS": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "bucketing_attributes": ["horizon.pool._session_type"],
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.pool.pool_usage_percent",
            "aggregation_function": "AVG"
          }
        ],
        "entities_by_integration": {
          "horizon": ["pool"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.pool._session_type = 'Desktop Session' and horizon.pool.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_APPLICATION_SESSION_UTILIZATION_FOR_AZURE_PODS": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "bucketing_attributes": ["horizon.pool._session_type"],
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.pool.pool_usage_percent",
            "aggregation_function": "AVG"
          }
        ],
        "entities_by_integration": {
          "horizon": ["pool"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.pool._session_type = 'Application Session' and horizon.pool.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_CAPACITY_USAGE_FOR_AZURE_PODS": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.pool.capacity_usage_percent",
            "aggregation_function": "AVG"
          }
        ],
        "entities_by_integration": {
          "horizon": ["pool"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.pool.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_SESSION_TOTAL_COUNT": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.session_snapshot.session_uuid",
            "aggregation_function": "COUNT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["session_snapshot"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.session_snapshot.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_SESSION_TOTAL_ACTIVE_COUNT": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.session_snapshot.session_uuid",
            "aggregation_function": "COUNT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["session_snapshot"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.session_snapshot.s_status = 'Active' and horizon.session_snapshot.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_SESSION_UNIQUE_USER_COUNT": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "counter_definitions": [
          {
            "aggregate_attribute":
                "horizon.session_snapshot.horizon_session_user",
            "aggregation_function": "COUNT_DISTINCT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["session_snapshot"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.session_snapshot.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_SESSION_IMPACTED_USERS": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "counter_definitions": [
          {
            "aggregate_attribute":
                "horizon.session_snapshot.horizon_session_user",
            "aggregation_function": "COUNT_DISTINCT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["session_snapshot"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.session_snapshot.adp_modified_at WITHIN 5 minutes and horizon.session_snapshot._impacted_flag = 'Impacted'",
        "cardinality": 30
      },
      "HORIZON_SESSION_SUMMARY_BY_SESSION_POOL_TYPE_AND_STATUS": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "bucketing_attributes": [
          "horizon.session_snapshot._session_pool_type",
          "horizon.session_snapshot.s_status"
        ],
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.session_snapshot.session_uuid",
            "aggregation_function": "COUNT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["session_snapshot"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.session_snapshot.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_SESSION_SUMMARY_BY_CLIENT_TYPE": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "bucketing_attributes": ["horizon.session_snapshot._view_client_type"],
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.session_snapshot.session_uuid",
            "aggregation_function": "COUNT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["session_snapshot"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.session_snapshot.s_status IN ('Active', 'Idle') and horizon.session_snapshot.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_SESSION_IMPACTED_USERS_BY_POD": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "bucketing_attributes": [
          "horizon.session_snapshot.pod_name",
          "horizon.session_snapshot._impacted_flag"
        ],
        "counter_definitions": [
          {
            "aggregate_attribute":
                "horizon.session_snapshot.horizon_session_user",
            "aggregation_function": "COUNT_DISTINCT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["session_snapshot"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.session_snapshot.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_SESSION_IMPACTED_USERS_BY_POOL": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "bucketing_attributes": [
          "horizon.session_snapshot.pool",
          "horizon.session_snapshot._impacted_flag"
        ],
        "counter_definitions": [
          {
            "aggregate_attribute":
                "horizon.session_snapshot.horizon_session_user",
            "aggregation_function": "COUNT_DISTINCT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["session_snapshot"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.session_snapshot.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      }
    };
    // Uri uri = Uri.https(authority, path);
    Uri uri = Uri.parse(authority + path);
    // document.cookie = authToken;
    http.Response result = await http.post(uri,
        headers: {
          // 'Authorization': 'Bearer $authToken'
          'content-type': 'application/json'
        },
        body: json.encode(body));
    dynamic resultBody = json.decode(result.body);
    TrendData trendData = TrendData.fromJson(resultBody['data']
        ['HORIZON_SESSION_SUMMARY_BY_SESSION_POOL_TYPE_AND_STATUS']);
    print(trendData);
    return trendData;
  }

  Future<dynamic> getSessionData() async {
    Object body = {
      "HORIZON_TOTAL_LOCATION_COUNT": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.pod.location",
            "aggregation_function": "COUNT_DISTINCT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["pod"]
        },
        "filter": "horizon.pod.adp_modified_at WITHIN 24 HOURS",
        "cardinality": 30
      },
      "HORIZON_TOTAL_DEPLOYMENT_COUNT": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.pod._deployment_type",
            "aggregation_function": "COUNT_DISTINCT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["pod"]
        },
        "filter": "horizon.pod.adp_modified_at WITHIN 24 HOURS",
        "cardinality": 30
      },
      "HORIZON_TOTAL_POD_COUNT": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.pod.pod_name",
            "aggregation_function": "COUNT_DISTINCT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["pod"]
        },
        "filter": "horizon.pod.adp_modified_at WITHIN 24 HOURS",
        "cardinality": 30
      },
      "HORIZON_TOTAL_POOL_COUNT": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.pool.pool_uid",
            "aggregation_function": "COUNT_DISTINCT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["pool"]
        },
        "filter": "horizon.pool.adp_modified_at WITHIN 24 HOURS",
        "cardinality": 30
      },
      "HORIZON_CPU_UTILIZATION_FOR_VMWARE_SDDC_PODS": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "bucketing_attributes": ["horizon.pod._deployment_type"],
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.pod.cpu_used_percent",
            "aggregation_function": "AVG"
          }
        ],
        "entities_by_integration": {
          "horizon": ["pod"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.pod.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_MEMORY_UTILIZATION_FOR_VMWARE_SDDC_PODS": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "bucketing_attributes": ["horizon.pod._deployment_type"],
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.pod.mem_used_percent",
            "aggregation_function": "AVG"
          }
        ],
        "entities_by_integration": {
          "horizon": ["pod"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.pod.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_DISK_UTILIZATION_FOR_VMWARE_SDDC_PODS": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "bucketing_attributes": ["horizon.pod._deployment_type"],
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.pod.disk_used_percent",
            "aggregation_function": "AVG"
          }
        ],
        "entities_by_integration": {
          "horizon": ["pod"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.pod.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_DESKTOP_SESSION_UTILIZATION_FOR_AZURE_PODS": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "bucketing_attributes": ["horizon.pool._session_type"],
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.pool.pool_usage_percent",
            "aggregation_function": "AVG"
          }
        ],
        "entities_by_integration": {
          "horizon": ["pool"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.pool._session_type = 'Desktop Session' and horizon.pool.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_APPLICATION_SESSION_UTILIZATION_FOR_AZURE_PODS": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "bucketing_attributes": ["horizon.pool._session_type"],
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.pool.pool_usage_percent",
            "aggregation_function": "AVG"
          }
        ],
        "entities_by_integration": {
          "horizon": ["pool"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.pool._session_type = 'Application Session' and horizon.pool.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_CAPACITY_USAGE_FOR_AZURE_PODS": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.pool.capacity_usage_percent",
            "aggregation_function": "AVG"
          }
        ],
        "entities_by_integration": {
          "horizon": ["pool"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.pool.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_SESSION_TOTAL_COUNT": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.session_snapshot.session_uuid",
            "aggregation_function": "COUNT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["session_snapshot"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.session_snapshot.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_SESSION_TOTAL_ACTIVE_COUNT": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.session_snapshot.session_uuid",
            "aggregation_function": "COUNT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["session_snapshot"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.session_snapshot.s_status = 'Active' and horizon.session_snapshot.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_SESSION_UNIQUE_USER_COUNT": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "counter_definitions": [
          {
            "aggregate_attribute":
                "horizon.session_snapshot.horizon_session_user",
            "aggregation_function": "COUNT_DISTINCT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["session_snapshot"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.session_snapshot.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_SESSION_IMPACTED_USERS": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "counter_definitions": [
          {
            "aggregate_attribute":
                "horizon.session_snapshot.horizon_session_user",
            "aggregation_function": "COUNT_DISTINCT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["session_snapshot"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.session_snapshot.adp_modified_at WITHIN 5 minutes and horizon.session_snapshot._impacted_flag = 'Impacted'",
        "cardinality": 30
      },
      "HORIZON_SESSION_SUMMARY_BY_SESSION_POOL_TYPE_AND_STATUS": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "bucketing_attributes": [
          "horizon.session_snapshot._session_pool_type",
          "horizon.session_snapshot.s_status"
        ],
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.session_snapshot.session_uuid",
            "aggregation_function": "COUNT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["session_snapshot"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.session_snapshot.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_SESSION_SUMMARY_BY_CLIENT_TYPE": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "bucketing_attributes": ["horizon.session_snapshot._view_client_type"],
        "counter_definitions": [
          {
            "aggregate_attribute": "horizon.session_snapshot.session_uuid",
            "aggregation_function": "COUNT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["session_snapshot"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.session_snapshot.s_status IN ('Active', 'Idle') and horizon.session_snapshot.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_SESSION_IMPACTED_USERS_BY_POD": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "bucketing_attributes": [
          "horizon.session_snapshot.pod_name",
          "horizon.session_snapshot._impacted_flag"
        ],
        "counter_definitions": [
          {
            "aggregate_attribute":
                "horizon.session_snapshot.horizon_session_user",
            "aggregation_function": "COUNT_DISTINCT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["session_snapshot"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.session_snapshot.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      },
      "HORIZON_SESSION_IMPACTED_USERS_BY_POOL": {
        "trend_mode": "SNAPSHOT",
        "accumulate": false,
        "bucketing_attributes": [
          "horizon.session_snapshot.pool",
          "horizon.session_snapshot._impacted_flag"
        ],
        "counter_definitions": [
          {
            "aggregate_attribute":
                "horizon.session_snapshot.horizon_session_user",
            "aggregation_function": "COUNT_DISTINCT"
          }
        ],
        "entities_by_integration": {
          "horizon": ["session_snapshot"]
        },
        "filter":
            "horizon.pod.pod_id IN ( 'e59b122b-5aa3-4551-9252-3b3e5dd4b890' ) AND horizon.session_snapshot.adp_modified_at WITHIN 5 minutes",
        "cardinality": 30
      }
    };
    // Uri uri = Uri.https(authority, path);
    Uri uri = Uri.parse(authority + path);
    // document.cookie = authToken;
    http.Response result = await http.post(uri,
        headers: {
          // 'Authorization': 'Bearer $authToken'
          'content-type': 'application/json'
        },
        body: json.encode(body));
    dynamic resultBody = json.decode(result.body);
    dynamic trendData = resultBody['data']
        ['HORIZON_SESSION_SUMMARY_BY_SESSION_POOL_TYPE_AND_STATUS'];
    print(trendData);
    return trendData;
  }
}
