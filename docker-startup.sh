#!/bin/bash
# Bash docker environment management script
# Version 1.0
# Michael Aggerholm
# 28/09-23

# Paths
TIGERCMS="$HOME/PhpstormProjects/tigercms/docker-compose.yml"
WORDPRESS="$HOME/PhpstormProjects/wordpress/docker-compose.yml"
JISPORT="$HOME/Documents/Jisport/docker-compose.yml"

# Handle parameters provided
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        --start)
            SERVICE="$2"
            docker_compose_file=""
            case $SERVICE in
                "tigercms")
                    docker_compose_file="$TIGERCMS"
                    ;;
                "wordpress")
                    docker_compose_file="$WORDPRESS"
                    ;;
                "jisport")
                    docker_compose_file="$JISPORT"
                    ;;
		"all")
                    echo "Starting all docker environments"
                    docker compose -f "$TIGERCMS" start
                    docker compose -f "$WORDPRESS" start
                    docker compose -f "$JISPORT" start
                    echo "Start all docker environments, will now exit script"
                    exit 0
                    ;;

                *)
                    echo "Unknown service: $SERVICE"
                    exit 1
                    ;;
            esac
            echo "Starting $SERVICE"
            docker compose -f "$docker_compose_file" up -d
	    echo "Started $SERVICE, will now exit script"
            exit 1
            ;;
	--restart)
            SERVICE="$2"
            docker_compose_file=""
            case $SERVICE in
                "tigercms")
                    docker_compose_file="$TIGERCMS"
                    ;;
                "wordpress")
                    docker_compose_file="$WORDPRESS"
                    ;;
                "jisport")
                    docker_compose_file="$JISPORT"
                    ;;
		"all")
                    echo "Restarting all docker environments"
                    docker compose -f "$TIGERCMS" restart
                    docker compose -f "$WORDPRESS" restart
                    docker compose -f "$JISPORT" restart
                    echo "Restarted all docker environments, will now exit script"
                    exit 0
                    ;;

                *)
                    echo "Unknown service: $SERVICE"
                    exit 1
                    ;;
            esac
            echo "Restarting $SERVICE"
            docker compose -f "$docker_compose_file" restart
            echo "Restarted $SERVICE, will now exit script"
            exit 1
	    ;;
	 --stop)
            SERVICE="$2"
            docker_compose_file=""
            case $SERVICE in
                "tigercms")
                    docker_compose_file="$TIGERCMS"
                    ;;
                "wordpress")
                    docker_compose_file="$WORDPRESS"
                    ;;
                "jisport")
                    docker_compose_file="$JISPORT"
                    ;;
		"all")
                    echo "Stopping all docker environments"
                    docker compose -f "$TIGERCMS" stop
                    docker compose -f "$WORDPRESS" stop
                    docker compose -f "$JISPORT" stop
                    echo "Stopped all docker environments, will now exit script"
                    exit 0
                    ;;
                *)
                    echo "Unknown service: $SERVICE"
                    exit 1
                    ;;
            esac
            echo "Stopping $SERVICE"
            docker compose -f "$docker_compose_file" stop
            echo "Stopped $SERVICE, will now exit script"
            exit 1
	    ;;
        --down)
            SERVICE="$2"
            docker_compose_file=""
            case $SERVICE in
                "tigercms")
                    docker_compose_file="$TIGERCMS"
                    ;;
                "wordpress")
                    docker_compose_file="$WORDPRESS"
                    ;;
                "jisport")
                    docker_compose_file="$JISPORT"
                    ;;
                "all")
                    echo "Downing all docker environments"
                    docker compose -f "$TIGERCMS" down
                    docker compose -f "$WORDPRESS" down
                    docker compose -f "$JISPORT" down
                    echo "Downed all docker environments, will now exit script"
		    exit 0
                    ;;
                *)
                    echo "Unknown service: $SERVICE"
                    exit 1
                    ;;
            esac
            echo "Downing $SERVICE"
            docker compose -f "$docker_compose_file" down
            echo "Downed $SERVICE, will now exit script"
            exit 1
	    ;;
        --container)
            SERVICE="$2"
	    CONTAINER_NAME="$3"
            case $SERVICE in
                "--restart")
	 	    docker restart "$CONTAINER_NAME"
                    ;;
                "--start")
                    docker start "$CONTAINER_NAME"
                    ;;
                "--logs")
                    docker logs "$CONTAINER_NAME"
                    ;;
                "--stop")
		    docker stop "$CONTAINER_NAME"
                    exit 0
                    ;;
                *)
                    echo "Unknown container: $CONTAINER_NAME"
                    exit 1
                    ;;
            esac
	    exit 1
            ;;
        --stats)
	    docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.State}}\t{{.Ports}}"
            exit 1
            ;;
	--help)
	    echo "Docker-startup help."
	    echo "Available docker environments:"
	    echo "tigercms"
	    echo "wordpress"
	    echo "jisport"
	    echo ""
	    echo "Available parameters:"
	    echo "--start			# Start a docker environment"
	    echo "--restart		# Restart a docker environment"
	    echo "--down			# Down a docker environment"
	    echo "--stop			# Stop a docker environment"
	    echo "--stats			# Gives docker stats for running containers"
	    echo "--help			# Provides this help menu.. dummy"
	    echo ""
	    echo "Example usages:" 
	    echo "--start tigercms	# Start tigercms"
	    echo "--down tigercms		# Down tigercms"
	    echo "--down all		# Down all docker environments"
	    echo ""
	    echo "The option 'all' is available for all docker environment options"
	    echo ""
	    echo "Container parameter: --container"
	    echo "--container parameters:"
	    echo "--restart"
	    echo "--start"
	    echo "--logs"
	    echo "--stop"
	    echo ""
	    echo "Example usages:"
	    echo "--stats					# To get a list of all running containers"
	    echo "--container --restart tigercmspma	# Restart the tigercmspma container"
	    echo ""
	    exit 1
	    ;;
        *)
            echo "Unknown parameter: $1"
            exit 1
            ;;
    esac
done

# If no valid parameter is provided
echo "No valid parameter provided, use --help if confused in wilderness"
exit 1
