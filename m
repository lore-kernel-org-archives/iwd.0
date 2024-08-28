Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E123A1DA32
	for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 02:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724813834; cv=none; b=QK9XBKcTXl21jE/MY3B+NX7yhwH3S7b9WpzjXT54BPke+f4EJDl7A5ucQ60NHHCslep04ZUv+K+Ald4zE3jbFm/e+0qWqMm6Bj8/cYMtp+0iXzy5LMgTlxc+21nQIWEZEEy7sheGaWET2Gz1DEhokD1sClLEByI9QvRBDt11s5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724813834; c=relaxed/simple;
	bh=zGf2vXgqqB2id+6bDcwPqRiTRyQCKeD62YzbD5YZ5Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dQj5/UFu+JdTdnU0/wZg4vr8KLehnvjWPWJLqUI4Aijvq/87w/k9XRVz9Ys2PXevyOD9wYcQuycBYKBtZf2WXa6Yy+s4tEi8jFgHmEac7wI1Lg7cL9eJheZsVrzzQ8ekp+5DNNNRxoJt8U6wh7VdHkpbYpgEciENwg1AqTLFi0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOJY2OpR; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOJY2OpR"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-273cf9bbb3eso4215685fac.1
        for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 19:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724813832; x=1725418632; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rsh8Njl8gZrEhapeIfZ9HS37Nku+b3KNnpdsU5tFDU4=;
        b=TOJY2OpR6h7VBcwnf4r/DbNkEvqf9E+7BIRj9aMk/HjVSTXMGIE36Y39QqOFbYp3RJ
         aAOtGrZH4DzvPvoOXbiMSqO9YL1LOB5EmI1fnuj8M+socR9vg4BAj8OK6PcpAfliQ4Nf
         JtbFYmechfhx5y92pQZf9GbDz1HsNOFfT39c7mtKdIqof1O6xGhSBAqiyPlWMjfr6Kms
         ajqgK/J8gGFendxonTiGL8LSDnBH0jirQC0Lh6gZiSn70+dLQKAf/9De+PncQTee2/Ct
         a4Fdhsf4g9f8HHlMI4wLuBzD6IRp08VPDabWo4cW2kUgZ/Qod7ooK/fCy7hj1+J9JDkX
         S7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724813832; x=1725418632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rsh8Njl8gZrEhapeIfZ9HS37Nku+b3KNnpdsU5tFDU4=;
        b=MPZHYfAx51362L1T0k5dXU4OWWvRCRHVUCFY7fJc6vmtilrXS5JL9D5FyAwfC6iHhQ
         34BKcLevqyAPVo4W/bm0N0BOo/Nk/4EtbFFldBnXueqmPnxcocdgHK3+bWZkVgvRMpF/
         uJzvAPueK97tJvIZLxk8Fgyls/nXfSS1JxzruVVsp7bCLhV5VBmsXGNcJX/Z1onhfBYu
         Mnh9J6zBuekBAYCaM8EnlwCEo+dkiJilrg7MV9nD1P3ZMQlOxykxIhd0fQtXS1j9g9TP
         DXXiDJyyYURX5m49pja2wADbG83BEk1VD2PuTgf3Kli592mNLLAWbKb1a94WKSpWDv/i
         MVug==
X-Forwarded-Encrypted: i=1; AJvYcCUnQZIi4rTp/YPl+c0w+Mzhn1q3GUI+6d+6ZPx/xrszEBfW3/QDuaMQBAZ/gBTvMV8/DV8=@lists.linux.dev
X-Gm-Message-State: AOJu0YyfpRguDjfmSirLvOR7k8aBb6xDltjIJlrfX4qJdJML0Xs+sni8
	j7RQu8bvUVG809NBVuBG9WJGLOPt4B6DGHRaNEXXo14eFIS82vza
X-Google-Smtp-Source: AGHT+IFfujh1vh8Fj0E9rLbZnj6DLSOqZmFb9iBKpmYq9sWvFG+ET7mby74mGrJJnNq0Hvh9qVOjtA==
X-Received: by 2002:a05:6871:51d2:b0:270:225d:559d with SMTP id 586e51a60fabf-2777d1f47d3mr540967fac.30.1724813831936;
        Tue, 27 Aug 2024 19:57:11 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-273cebc5b2dsm3517938fac.49.2024.08.27.19.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 19:57:11 -0700 (PDT)
Message-ID: <cf53e0e8-4ec4-48ce-8abd-b0c2f2b39d9c@gmail.com>
Date: Tue, 27 Aug 2024 21:57:10 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] station: add Affinities DBus property
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240823222339.328006-1-prestwoj@gmail.com>
 <20240823222339.328006-5-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240823222339.328006-5-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/23/24 5:23 PM, James Prestwood wrote:
> This property will hold an array of object paths for
> BasicServiceSet (BSS) objects. For the purpose of this patch
> only the setter/getter and client watch is implemented. The
> purpose of this array is to guide or loosly lock IWD to certain

typo: 'loosely'

> BSS's provided that some external client has more information
> about the environment than what IWD takes into account for its
> roaming decisions.
> 
> For the time being, the array is limited to only the connected
> BSS path, and any roams or disconnects will clear the array.
> 
> The intended use case for this is if the device is stationary
> an external client could reduce the likelihood of roaming by
> setting the affinity to the current BSS.
> ---
>   src/station.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 145 insertions(+)
> 
> diff --git a/src/station.c b/src/station.c
> index 30a1232a..c72d42ae 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -128,6 +128,10 @@ struct station {
>   
>   	uint64_t last_roam_scan;
>   
> +	struct l_queue *affinities;
> +	unsigned int affinity_watch;
> +	char *affinity_client;
> +
>   	bool preparing_roam : 1;
>   	bool roam_scan_full : 1;
>   	bool signal_low : 1;
> @@ -449,6 +453,14 @@ static const char *station_get_bss_path(struct station *station,
>   	return __network_path_append_bss(network_path, bss);
>   }
>   
> +static bool match_bss_path(const void *data, const void *user_data)
> +{
> +	const char *path1 = data;
> +	const char *path2 = user_data;
> +
> +	return !strcmp(path1, path2);
> +}
> +
>   static bool station_unregister_bss(struct station *station,
>   					struct scan_bss *bss)
>   {
> @@ -457,6 +469,8 @@ static bool station_unregister_bss(struct station *station,
>   	if (L_WARN_ON(!path))
>   		return false;
>   
> +	l_queue_remove_if(station->affinities, match_bss_path, path);
> +
>   	return l_dbus_unregister_object(dbus_get_bus(), path);
>   }
>   
> @@ -1740,6 +1754,13 @@ static void station_enter_state(struct station *station,
>   		station_set_evict_nocarrier(station, true);
>   		station_set_drop_neighbor_discovery(station, false);
>   		station_set_drop_unicast_l2_multicast(station, false);
> +
> +		if (station->affinity_watch) {
> +			l_dbus_remove_watch(dbus_get_bus(),
> +						station->affinity_watch);
> +			station->affinity_watch = 0;
> +		}
> +

Hmm, but not resetting affinities?

>   		break;
>   	case STATION_STATE_DISCONNECTING:
>   	case STATION_STATE_NETCONFIG:
> @@ -1747,6 +1768,12 @@ static void station_enter_state(struct station *station,
>   	case STATION_STATE_ROAMING:
>   	case STATION_STATE_FT_ROAMING:
>   	case STATION_STATE_FW_ROAMING:
> +		if (station->affinity_watch) {
> +			l_dbus_remove_watch(dbus_get_bus(),
> +						station->affinity_watch);
> +			station->affinity_watch = 0;

Okay.  This reminds me that for hardware supporting FW roaming we may want to 
return NotCapable when setting Affinities.

> +		}
> +
>   		station_set_evict_nocarrier(station, false);
>   		break;
>   	}

<snip>

> +static void station_affinity_watch_destroy(void *user_data)
> +{
> +	struct station *station = user_data;
> +
> +	l_free(station->affinity_client);
> +	station->affinity_client = NULL;
> +
> +	l_queue_destroy(station->affinities, l_free);
> +	station->affinities = NULL;
> +
> +	l_dbus_property_changed(dbus_get_bus(),
> +				netdev_get_path(station->netdev),
> +				IWD_STATION_INTERFACE, "Affinities");

What if the list was empty?

> +}
> +
> +static struct l_dbus_message *station_property_set_affinities(
> +					struct l_dbus *dbus,
> +					struct l_dbus_message *message,
> +					struct l_dbus_message_iter *new_value,
> +					l_dbus_property_complete_cb_t complete,
> +					void *user_data)
> +{
> +	struct station *station = user_data;
> +	struct l_dbus_message_iter array;
> +	const char *sender = l_dbus_message_get_sender(message);
> +	const char *path;
> +	struct l_queue *new_affinities;
> +
> +	if (!station->connected_network)
> +		return dbus_error_not_connected(message);
> +
> +	if (!station->affinity_watch) {
> +		station->affinity_client = l_strdup(sender);
> +		station->affinity_watch = l_dbus_add_disconnect_watch(dbus,
> +					sender,
> +					station_affinity_disconnected_cb,
> +					station,
> +					station_affinity_watch_destroy);
> +	} else if (strcmp(station->affinity_client, sender)) {
> +		l_warn("Only one client may manage Affinities property");
> +		return dbus_error_not_available(message);

Hmm, we probably need a new error for 'permission denied or something'

> +	}
> +
> +	if (!l_dbus_message_iter_get_variant(new_value, "ao", &array))
> +		return dbus_error_invalid_args(message);

So what happens to affinity_client / affinity_watch above?

> +
> +	new_affinities = l_queue_new();
> +
> +	while (l_dbus_message_iter_next_entry(&array, &path)) {
> +		struct scan_bss *bss = l_dbus_object_get_data(dbus_get_bus(),
> +						path,
> +						IWD_BSS_INTERFACE);
> +
> +		/*
> +		 * TODO: For now only allow the affinities array to contain the
> +		 *       connected BSS path. Any other values will be rejected.
> +		 *       This could change in the future.
> +		 */
> +		if (bss != station->connected_bss) {
> +			l_queue_destroy(new_affinities, l_free);
> +			return dbus_error_invalid_args(message);

same as above?

You may want to make your life easier by just looking for an empty list or list 
of size 1 with the connected bss.

> +		}
> +
> +		l_queue_push_head(new_affinities, l_strdup(path));
> +	}
> +
> +	l_queue_destroy(station->affinities, l_free);
> +	station->affinities = new_affinities;

If the list is empty, should you unregister the watch?

> +
> +	l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
> +				IWD_STATION_INTERFACE, "Affinities");
> +
> +	complete(dbus, message, NULL);

It is the other way around, we send the 'message_return' first, then the signal. 
  Do you want to spuriously emit if the two lists are the same?

> +
> +	return NULL;
> +}
> +
>   void station_foreach(station_foreach_func_t func, void *user_data)
>   {
>   	const struct l_queue_entry *entry;

Regards,
-Denis

