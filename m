Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4937339B4
	for <iwd@lists.linux.dev>; Wed, 18 Oct 2023 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZ+DKSIu"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d857c8a1d50so6908866276.3
        for <iwd@lists.linux.dev>; Wed, 18 Oct 2023 05:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697633509; x=1698238309; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJNrzxd1xT5bUDz+/76ZpMEueePZd+bkD15VzwSFIFI=;
        b=gZ+DKSIuHxTrRfq0kcrrxp9eo4lrYxoh3BceYyUdbyXqgnjsvx69bC55eJ8WO9U9H3
         E0UDvOL2xUnBVZMEqrqYuUhIULDE4GUGujNcNA5Pc0d8ZUFRtFpTOpZsfUpSl/+P2RxO
         Tbw9vqcEqemPfzv6tyT4AucHGZnUXErQNUIQ3wuhb//K/TZMaVErKMm/UtfhZEUc31We
         uR/0kDyP2imqI9CxOmy4B1Kd9U3X4l5zHsoUXVT7hTXc7Oqjh3Jb3z+fgxfkflVtxdOm
         OeGB0UVYlLV/CI/q6Asxs5dMmpr3mlnMHWNncwfRk1vje+HtZaEAIJf2q2W8E2miyjWv
         /87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697633509; x=1698238309;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJNrzxd1xT5bUDz+/76ZpMEueePZd+bkD15VzwSFIFI=;
        b=u0WknCTIGL/vhgB79BZma/FRXWepChs8BaDSf1NlQxbTihQNlwBpgepjR0qQ7HavIG
         lNBhU+fzN+uo68UBSnPMQX2Sn8FcEH1pYqM4XpYqvlMcY7C7r6i8pL/bY+ie4GHaiHW0
         wmVHl1POI6e1CGwJAf6hE7Mwzyg6BUKjTrrpcdM3uBbm/ewflxyTc2C00+R8NJzHqRR+
         kUQnW8Fm/qi+OL57fqB823xTeGHr7ZBTuT2bzbyIJrpBt9UVP6Wjq7EJreNL9GZTcP1k
         CR6NBbD/Ao7r5jbvA6//LlNTSqBG8bNtF8ThaZHQwqnDmEUdZVWFVaMNspUT0iVRrvhQ
         aVdg==
X-Gm-Message-State: AOJu0YwB7wO+YYP4xMd0Uq0oTYGTX6qQXwQqpOArcZ9DB1XKfRjyqFmW
	ERs0miEDi8nWlTBFyD3xFwM=
X-Google-Smtp-Source: AGHT+IENTCR4wOSefkk+GhiylESN6XdcmzTnyqRaLbchDN/75ju+7tJwi+zIUcZKEPc73hXc3+WeOw==
X-Received: by 2002:a25:4c02:0:b0:d9a:64ca:8fbc with SMTP id z2-20020a254c02000000b00d9a64ca8fbcmr4442799yba.46.1697633509344;
        Wed, 18 Oct 2023 05:51:49 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id i8-20020a0cfcc8000000b0065b260eafd9sm1332100qvq.87.2023.10.18.05.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 05:51:49 -0700 (PDT)
Message-ID: <8bef6b0a-8284-4889-bd23-b33e26b450f2@gmail.com>
Date: Wed, 18 Oct 2023 05:51:47 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add AllowRoaming station property
Content-Language: en-US
To: =?UTF-8?Q?Pedro_Andr=C3=A9?= <PEDA@bang-olufsen.dk>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <20231018122534.33455-1-peda@bang-olufsen.dk>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20231018122534.33455-1-peda@bang-olufsen.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Pedro,

On 10/18/23 5:27 AM, Pedro André wrote:
> From: Pedro Andre <peda@bang-olufsen.dk>
> 
> This adds an AllowRoaming property to the station struct that makes it
> possible to indicate to the station/interface that it should not go
> into roaming state (when set to false). This property defaults to true
> (i.e. it defaults to the normal iwd behaviour that allows roaming).
> 
> ---
>   src/station.c | 40 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/src/station.c b/src/station.c
> index 065687d..00254b7 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -130,6 +130,7 @@ struct station {
>   	bool autoconnect : 1;
>   	bool autoconnect_can_start : 1;
>   	bool netconfig_after_roam : 1;
> +	bool allow_roaming : 1;
>   };
>   
>   struct anqp_entry {
> @@ -2754,6 +2755,9 @@ static bool station_cannot_roam(struct station *station)
>   	const struct l_settings *config = iwd_get_config();
>   	bool disabled;
>   
> +	if (!station->allow_roaming)
> +		return true;
> +
>   	/*
>   	 * Disable roaming with hardware that can roam automatically. Note this
>   	 * is now required for recent kernels which have CQM event support on
> @@ -4155,6 +4159,38 @@ static bool station_property_get_state(struct l_dbus *dbus,
>   	return true;
>   }
>   
> +static bool station_property_get_allow_roaming(struct l_dbus *dbus,
> +					struct l_dbus_message *message,
> +					struct l_dbus_message_builder *builder,
> +					void *user_data)
> +{
> +	struct station *station = user_data;
> +	bool roaming = station->allow_roaming;
> +
> +	l_dbus_message_builder_append_basic(builder, 'b', &roaming);
> +	return true;
> +}
> +
> +static struct l_dbus_message *station_property_set_allow_roaming(
> +					struct l_dbus *dbus,
> +					struct l_dbus_message *message,
> +					struct l_dbus_message_iter *new_value,
> +					l_dbus_property_complete_cb_t complete,
> +					void *user_data)
> +{
> +	struct station *station = user_data;
> +	bool roaming;
> +
> +	if (!l_dbus_message_iter_get_variant(new_value, "b", &roaming))
> +		return dbus_error_invalid_args(message);
> +
> +	l_debug("Setting allow_roaming %s", roaming ? "true" : "false");
> +
> +	station->allow_roaming = roaming;
> +
> +	return l_dbus_message_new_method_return(message);
> +}
> +
>   void station_foreach(station_foreach_func_t func, void *user_data)
>   {
>   	const struct l_queue_entry *entry;
> @@ -4358,6 +4394,8 @@ static struct station *station_create(struct netdev *netdev)
>   
>   	station->roam_bss_list = l_queue_new();
>   
> +	station->allow_roaming = true;
> +
>   	return station;
>   }
>   
> @@ -4484,6 +4522,8 @@ static void station_setup_interface(struct l_dbus_interface *interface)
>   					station_property_get_scanning, NULL);
>   	l_dbus_interface_property(interface, "State", 0, "s",
>   					station_property_get_state, NULL);
> +	l_dbus_interface_property(interface, "AllowRoaming", 0, "b",
> +				station_property_get_allow_roaming, station_property_set_allow_roaming);
>   }
>   
>   static void station_destroy_interface(void *user_data)

LGTM, I actually needed something along these lines for dynamically 
disabling roaming e.g. during a software upgrade or some time when 
networking is critical. Just hadn't gotten to it yet.

Thanks,
James
