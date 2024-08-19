Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52756381B1
	for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080959; cv=none; b=I+SZpe+62OJtjRpPE8ZX40kKxG0a6MMHLs5uNW4Mpw69nIW2Fehn6t7bjCt21wkskvenZ8ggjNkpCi/M6k5Ezc5EdWYZ64PU9rZY9H33LkkYFoI507ONUgGBgdLKdTs3IVtXs2A3y9tbM8h2BQrGyNLoqS+p58QhVmWucT+nJZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080959; c=relaxed/simple;
	bh=OkHjoS3GxIQYTMg7BrK3LJPCF6cyPhUtKaA69xCHBv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xztxk0jNS0WwcF0gbP93HSUXUa5uXacqNzm2640d+Eg97OSbOYUldg3Cf9wOWSe6w27Pqpb4Dm+mtHW5OT8Dd+DVonxbHGNepN0lCNN6WRx12/xBfvLbBuciqdX7oW7UND1vVN54OYA3DFcA8lbMAXhzz+ghUh58VSWmdNP69/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KY6vKHam; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY6vKHam"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2701c010388so1700105fac.0
        for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 08:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724080957; x=1724685757; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3yLEE8wud0mZRWU8BJjllTwyKSP8vCbEyw1nt6ainZU=;
        b=KY6vKHamCXv0eg2kt8VqjTpJ2DT+8eFlhFTpQIUGCg+weCMJCbEq48R51dd6M1w5Vg
         cdJamBao6KScefVYtTEOxZmWjoeQXJJjdPiIvEibcrGR4dwiCRVXhhTP4JoHwqowEJxO
         ta9hxoowGqmuKrQ+uQoxKdQtp2tOwRxeVcQoqF8nPoYx7ZLpSmNp4oVCinpNPK2tg7PF
         e+yhkLhLINrPo48TtQ7Rv1yWxtSNFXbJvU3qclNtObfpaGBAei1yIEjtKZlosmd5QURA
         WFICCX0/CML9UV728rxHdRRqQpyLhz8j6FTjhfSUWkFtPvPP9HvbgUEG6nuFc/SXtY1g
         v8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724080957; x=1724685757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3yLEE8wud0mZRWU8BJjllTwyKSP8vCbEyw1nt6ainZU=;
        b=MlJIALa9BDFN0pkk/RmXTpo4ObxA0QEGdYfOUQom3Frv0bs0MZBn5/z+dw5o/96XL4
         4FxY5AxAiDItKzMcFw419yLKPvg3cpDt4fV3E+y0DUYxeV+2IYqXdidBQ6ey7/R7d/Zu
         IYh6aU/J/mhfQyC8Yof5fTkWOEmizMceFjbe/cNO4IThvBymKvhH9OcQTTG7lzpc/Mdj
         VI3LA1otx2hCMbgoEYOCwyiVAZ73I7UDQhzntKiOa+6xPXxHNpq/sVKx7qEqFlWQnkH8
         q45EQK4UHLWtsJMLT9J+KlzrN+jsHgggV0XqtRCnG7yw4CZN3+E+BzPxnh93SeIbQ03C
         2SrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaavazxvjM2H4N8chy6a3s9eJOdL14tIyGXndZLrjfMkE1DN9OBRerluMMI/ARWveWXmcNlB+C43UGGGnEH/x/0Iqn
X-Gm-Message-State: AOJu0Yxd9F15NSkxQwtxy5wy+Q/wFsiKOqE2gan39U9EyQLEx2w/mR3y
	KRITIIxV1gkifR3dXemCaRvZy+fcVFBm0e9KSjc+OIIsTEy5zDSgHedkKw==
X-Google-Smtp-Source: AGHT+IEOMFl/GNTviSm+vZBHNwxGhfnzw7QjMvkK8fj/+TOz6Th3W2d166hT5MxN7yfcd21UZevN+w==
X-Received: by 2002:a05:6871:758b:b0:270:14cc:656c with SMTP id 586e51a60fabf-2701c349552mr12658391fac.6.1724080957224;
        Mon, 19 Aug 2024 08:22:37 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2704eef4306sm1481487fac.17.2024.08.19.08.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 08:22:36 -0700 (PDT)
Message-ID: <550276f1-69a3-434b-9863-ac89e0575e63@gmail.com>
Date: Mon, 19 Aug 2024 10:22:36 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] station: move BasicServiceSet DBus management into
 station
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240816125214.1162415-1-prestwoj@gmail.com>
 <20240816125214.1162415-2-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240816125214.1162415-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/16/24 7:52 AM, James Prestwood wrote:
> Due to an unnoticed bug after adding the BasicServiceSet object into
> network, it became clear that since station already owns the scan_bss
> objects it makes sense for it to manage the associated DBus objects
> as well. This way network doesn't have to jump through hoops to
> determine if the scan_bss object was remove, added, or updated. It
> can just manage its list as it did prior.
> 
>  From the station side this makes things very easy. When scan results
> come in we either update or add a new DBus object. And any time a
> scan_bss is freed we remove the DBus object.
> ---
>   src/station.c | 89 +++++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 72 insertions(+), 17 deletions(-)
> 

<snip>

> @@ -431,6 +429,65 @@ static void station_print_scan_bss(const struct scan_bss *bss)
>   			optional);
>   }
>   
> +static const char *station_get_bss_path(struct station *station,
> +						struct scan_bss *bss)
> +{
> +	enum security security;
> +	char ssid[33];
> +	const char *network_path;
> +
> +	memcpy(ssid, bss->ssid, bss->ssid_len);
> +	ssid[bss->ssid_len] = '\0';
> +
> +	if (scan_bss_get_security(bss, &security) < 0)
> +		return NULL;
> +
> +	network_path = iwd_network_get_path(station, ssid, security);
> +	if (!network_path)
> +		return NULL;
> +
> +	return __network_path_append_bss(network_path, bss);
> +}
> +
> +static bool station_unregister_bss(struct station *station,
> +					struct scan_bss *bss)
> +{
> +	const char *path = station_get_bss_path(station, bss);
> +
> +	if (L_WARN_ON(!path))
> +		return false;
> +
> +	return l_dbus_unregister_object(dbus_get_bus(), path);
> +}
> +
> +static bool station_register_bss(struct station *station, struct scan_bss *bss)
> +{
> +	struct scan_bss *old;
> +	const char *path = station_get_bss_path(station, bss);
> +
> +	if (L_WARN_ON(!path))
> +		return false;
> +
> +	/*
> +	 * If we find this path in the object tree update the data to the new
> +	 * scan_bss pointer, as this one will be freed soon.
> +	 */
> +	old = l_dbus_object_get_data(dbus_get_bus(), path, IWD_BSS_INTERFACE);
> +	if (old)
> +		return l_dbus_object_set_data(dbus_get_bus(), path,
> +						IWD_BSS_INTERFACE, bss);
> +
> +	if (!l_dbus_object_add_interface(dbus_get_bus(), path,
> +						IWD_BSS_INTERFACE, bss))
> +		return false;
> +
> +	if (!l_dbus_object_add_interface(dbus_get_bus(), path,
> +					L_DBUS_INTERFACE_PROPERTIES, bss))
> +		return false;
> +
> +	return true;
> +}
> +
>   /*
>    * Returns the network object the BSS was added to or NULL if ignored.
>    */
> @@ -518,6 +575,7 @@ static struct network *station_add_seen_bss(struct station *station,
>   	}
>   
>   	network_bss_add(network, bss);
> +	station_register_bss(station, bss);

Hmm, you have the network object right above?  Can you utilize that somehow?

>   
>   	return network;
>   }
> @@ -540,7 +598,7 @@ struct bss_expiration_data {
>   	struct scan_bss *connected_bss;
>   	uint64_t now;
>   	const struct scan_freq_set *freqs;
> -	struct l_queue *free_list;
> +	struct station *station;
>   };
>   
>   #define SCAN_RESULT_BSS_RETENTION_TIME (30 * 1000000)
> @@ -562,20 +620,21 @@ static bool bss_free_if_expired(void *data, void *user_data)
>   			bss->time_stamp + SCAN_RESULT_BSS_RETENTION_TIME))
>   		return false;
>   
> -	l_queue_push_head(expiration_data->free_list, bss);
> +	station_unregister_bss(expiration_data->station, bss);
> +
> +	scan_bss_free(bss);
>   
>   	return true;
>   }
>   
>   static void station_bss_list_remove_expired_bsses(struct station *station,
> -					const struct scan_freq_set *freqs,
> -					struct l_queue *free_list)
> +					const struct scan_freq_set *freqs)
>   {
>   	struct bss_expiration_data data = {
>   		.now = l_time_now(),
>   		.connected_bss = station->connected_bss,
>   		.freqs = freqs,
> -		.free_list = free_list,
> +		.station = station,
>   	};
>   
>   	l_queue_foreach_remove(station->bss_list, bss_free_if_expired, &data);
> @@ -823,6 +882,7 @@ static bool station_owe_transition_results(int err, struct l_queue *bss_list,
>   
>   		l_queue_push_tail(station->bss_list, bss);
>   		network_bss_add(network, bss);
> +		station_register_bss(station, bss);

Same comment as above.

>   
>   		continue;
>   
> @@ -951,7 +1011,6 @@ void station_set_scan_results(struct station *station,
>   	const struct l_queue_entry *bss_entry;
>   	struct network *network;
>   	struct process_network_data data;
> -	struct l_queue *free_list = l_queue_new();
>   
>   	l_queue_foreach_remove(new_bss_list, bss_free_if_ssid_not_utf8, NULL);
>   
> @@ -963,7 +1022,7 @@ void station_set_scan_results(struct station *station,
>   	l_queue_destroy(station->autoconnect_list, NULL);
>   	station->autoconnect_list = NULL;
>   
> -	station_bss_list_remove_expired_bsses(station, freqs, free_list);
> +	station_bss_list_remove_expired_bsses(station, freqs);
>   
>   	for (bss_entry = l_queue_get_entries(station->bss_list); bss_entry;
>   						bss_entry = bss_entry->next) {
> @@ -975,12 +1034,8 @@ void station_set_scan_results(struct station *station,
>   			if (old_bss == station->connected_bss)
>   				station->connected_bss = new_bss;
>   
> -			/*
> -			 * The network object is still holding a reference to
> -			 * the BSS. Until we tell network to replace the BSS
> -			 * with a new object, don't free it.
> -			 */
> -			l_queue_push_head(free_list, old_bss);
> +			station_register_bss(station, new_bss);

Why do this here?  Can't you do this step in the loop below where we figure out 
the network object?

> +			scan_bss_free(old_bss);
>   
>   			continue;
>   		}
> @@ -1017,8 +1072,6 @@ void station_set_scan_results(struct station *station,
>   
>   	l_hashmap_foreach_remove(station->networks, process_network, &data);
>   
> -	l_queue_destroy(free_list, bss_free);
> -
>   	station->autoconnect_can_start = trigger_autoconnect;
>   	station_autoconnect_start(station);
>   }
> @@ -2652,6 +2705,7 @@ static void station_update_roam_bss(struct station *station,
>   		l_queue_remove_if(station->bss_list, bss_match, bss);
>   
>   	network_bss_update(network, bss);
> +	station_register_bss(station, bss);

Same here, can we use the network object somehow?

>   	l_queue_push_tail(station->bss_list, bss);
>   
>   	if (old)
> @@ -3160,6 +3214,7 @@ static void station_event_roamed(struct station *station, struct scan_bss *new)
>   	struct scan_bss *stale;
>   
>   	network_bss_update(station->connected_network, new);
> +	station_register_bss(station, new);

And here

>   
>   	/* Remove new BSS if it exists in past scan results */
>   	stale = l_queue_remove_if(station->bss_list, bss_match, new);

Regards,
-Denis
