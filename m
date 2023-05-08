Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09278566F
	for <iwd@lists.linux.dev>; Mon,  8 May 2023 18:06:27 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-18f4a6d2822so33056151fac.1
        for <iwd@lists.linux.dev>; Mon, 08 May 2023 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683569187; x=1686161187;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pU88vbWz/PKsbMntlklhvfJRuOxbjiAQrBfbaPHVTX8=;
        b=L2dDjjPUFHp4z1B8widAKr9zaYquWReCp9Fs4bGIMXX9ooEOXxG7aWyAFhRdbSCQ3S
         2c+L7hi9BbGQb4IqdUcaf3glp6AC9Z5/sTz0g0kxCwggKAsyCJTPmp2e8PYMYVTgH10e
         E79yojLE6oci8ieJg+gPXg6aR0QU2lxwAmj9gXbRpVnRakn3mpZ2H1Ew3mWcbp4z4Qzw
         UHrWZ4M9HEQhgC9fmP6/oRLot36QDE/GSq2gnrfZnGLfJEzW9VSP8Y4RPyt1m/WbsRqH
         /5WLBQr6Q//wnv4jxXWsC/h7UcX0nqclz2mfPAxzH/Upq2SnarM0ye0NX2HR7x+pUwYo
         2haQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683569187; x=1686161187;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pU88vbWz/PKsbMntlklhvfJRuOxbjiAQrBfbaPHVTX8=;
        b=VnxKHvl6aMviZurF41Midm6R1jPWfEEKY1vAKl1fqJUX/oURM9h2gISvWTG5lebBHs
         hhqzZNHP6+KhTVQKG96K9S/3D0tOt3UVDsZhCqUoWIJPO29Kdsq2ow+5+7FeElnVdbPJ
         vuPgNH0DlbnKSYMQqWE9K5d7TCEjL0IUi3z5mIEGa52PWUWGHbyQS6/LSPR2Ca9vVAii
         jl6fige/PF+Hr+VS9pGuiSQsSuPupesMqLlh3Ejsgi9nuAqlhiNaXtJ4Lc3x/Kq1i+rv
         QAOxSYZxtVuLR8VuGPj1yoqSEgKSm42klAxSvkiAeMl5IDZl2Oc/8yD3VdyTnda9IQap
         TBTQ==
X-Gm-Message-State: AC+VfDy7tSohuC2Ddz6U0Ul2xiSbLhq7KIiORvAUKH07PPw3QBctdviy
	OAVFCOsGnh3tCbLLhDxnSFs=
X-Google-Smtp-Source: ACHHUZ5x2n/qNURpfddbm8RX5iAQHHwRa9jtZ5L3ovf3M6cUPSCKVdjKZ4Mtu6nYw1xJ4RQeEv8Xqw==
X-Received: by 2002:a05:6830:2a9f:b0:6aa:fa6d:c80b with SMTP id s31-20020a0568302a9f00b006aafa6dc80bmr2729664otu.9.1683569186902;
        Mon, 08 May 2023 11:06:26 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id j16-20020a9d7690000000b006a6558ef17fsm4358894otl.30.2023.05.08.11.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 11:06:25 -0700 (PDT)
Message-ID: <7c38d268-7d00-e16c-ff18-de198ba11987@gmail.com>
Date: Mon, 8 May 2023 12:56:20 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] station: fix reentrant FT wiphy radio work insertion
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230501220604.366100-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230501220604.366100-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 5/1/23 17:06, James Prestwood wrote:
> The failure path for FT was inserting the same work item inside
> the 'do_work' callback. This caused duplicate work items to be
> inside the radio work queue, and upon destroy the ID would get
> zero'ed out. This caused a host of valgrind complaints when this
> behavior is triggered.
> 
> This can be seen with slight modifiations to the FT test:

Typo here, 'modifiations'

> 
> src/station.c:station_try_next_transition() 9, target 12:00:00:00:00:02
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 6
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 7
> src/wiphy.c:wiphy_radio_work_done() Work item 5 done
> src/wiphy.c:wiphy_radio_work_next() Starting work item 6
> src/netdev.c:netdev_mlme_notify() MLME notification Remain on Channel(55)
> src/ft.c:ft_send_authenticate()
> src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Status(60)
> src/netdev.c:netdev_mlme_notify() MLME notification Frame Wait Cancel(67)
> src/netdev.c:netdev_mlme_notify() MLME notification Cancel Remain on Channel(56)
> src/wiphy.c:wiphy_radio_work_done() Work item 6 done
> 
> --- Work item 7 is 'station_ft_work_ready()' ---
> 
> src/wiphy.c:wiphy_radio_work_next() Starting work item 7
> src/station.c:station_debug_event() StationDebug.Event(ft-roam-failed)
> src/station.c:station_try_next_transition() 9, target 12:00:00:00:00:03
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 8
> 
> --- Here we insert work item 9, which is a duplicate of 7 ---
> 

Duplicate in what way? We're going to a different BSS?  Or do you mean that we 
overwrite station->ft_work because we queue the same work item in the work queue 
callback?

> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 9
> src/wiphy.c:wiphy_radio_work_next() Starting work item 8
> src/netdev.c:netdev_mlme_notify() MLME notification Remain on Channel(55)
> src/ft.c:ft_send_authenticate()
> src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Status(60)
> src/netdev.c:netdev_mlme_notify() MLME notification Frame Wait Cancel(67)
> src/netdev.c:netdev_mlme_notify() MLME notification Cancel Remain on Channel(56)
> src/wiphy.c:wiphy_radio_work_done() Work item 8 done
> 
> --- And finally, the duplicated work item starts ---
> 
> src/wiphy.c:wiphy_radio_work_next() Starting work item 0
> src/station.c:station_debug_event() StationDebug.Event(ft-roam-failed)
> src/station.c:station_roam_failed() 9
> src/station.c:station_roam_trigger_cb() 9
> ---
>   src/station.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/src/station.c b/src/station.c
> index 0d8f7628..3c6e43ce 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -122,6 +122,7 @@ struct station {
>   
>   	uint32_t wiphy_watch;
>   
> +	struct l_idle *ft_idle;
>   	struct wiphy_radio_work_item ft_work;
>   
>   	bool preparing_roam : 1;
> @@ -1739,6 +1740,11 @@ static void station_roam_state_clear(struct station *station)
>   		station->roam_freqs = NULL;
>   	}
>   
> +	if (station->ft_idle) {
> +		l_idle_remove(station->ft_idle);
> +		station->ft_idle = NULL;
> +	}
> +
>   	l_queue_clear(station->roam_bss_list, l_free);
>   
>   	ft_clear_authentications(netdev_get_ifindex(station->netdev));
> @@ -2282,6 +2288,16 @@ static void station_preauthenticate_cb(struct netdev *netdev,
>   
>   static void station_transition_start(struct station *station);
>   
> +static void station_transition_idle(struct l_idle *idle, void *user_data)
> +{
> +	struct station *station = user_data;
> +
> +	l_idle_remove(station->ft_idle);
> +	station->ft_idle = NULL;
> +
> +	station_transition_start(station);
> +}
> +
>   static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
>   {
>   	struct station *station = l_container_of(item, struct station, ft_work);
> @@ -2300,7 +2316,8 @@ static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
>   	if (ret == -ENOENT) {
>   		station_debug_event(station, "ft-roam-failed");
>   try_next:
> -		station_transition_start(station);
> +		station->ft_idle = l_idle_create(station_transition_idle,
> +							station, NULL);
>   		return true;
>   	} else if (ret < 0)
>   		goto assoc_failed;

The patch makes sense to me.  However, I do wonder whether we can take care of 
this in the wiphy work queue itself?  Maybe by adding wiphy_work_reschedule() or 
something to that effect?  I would hate to keep doing this l_idle business every 
time we need to do something similar.

Regards,
-Denis
