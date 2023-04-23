Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176E3D76
	for <iwd@lists.linux.dev>; Sun, 23 Apr 2023 23:35:51 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-187b70ab997so21453164fac.0
        for <iwd@lists.linux.dev>; Sun, 23 Apr 2023 16:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682292950; x=1684884950;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YDuqrnrhr1wQ0tokDaGR5gAjnQMDrh5GgReO2ndvILI=;
        b=ixhQID8cRuplS9ir0nElL0ShcF9orCytFCR2d2Fq6L8WCeDW2AlWefnQAs9WsBPhFy
         dK7SKmVDXcoP7ssn3xFEN4caG4XkeTtld8Wy+ZY5AxgJakeVqATqXo2b36WxJ1XQm3ms
         jA4d/WkNITZiHW7rbppkFrpVuPDLDE5uMxccJbHQhxQKvs/mwP9J26fklxWDeHP63rZK
         QTcsND7P/BxPaBtARg9IVsH71+jsauWYPomIWTqbKmvZySN/kc2xK2eJ5nRdI4smSgWE
         Scs0APQF6bXOXI7QgGlsyCDe6HfCFaSNkol/fc3DJjbUBlSAz1W0G6EfV/fvAvCnZL6E
         WWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682292950; x=1684884950;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YDuqrnrhr1wQ0tokDaGR5gAjnQMDrh5GgReO2ndvILI=;
        b=S+ELVAkcLX4ulfvwe0jeMui6OneyYyUXx7JQrko9aIXXDZYUm0xBNid6GESIAWOjgY
         ihw627+omTs92BsmudN6nanZ8/zdemVHybHqDOZALEGRaH/FX0iLZg1IC5QcUz6iiXf2
         zVABqfA2gHh59PlsNZF3KJMKwFAS4WH0BniT8HpL6/i/Aw+Igsx7+KhoNkr+rfnnQrvd
         bauKx8DrL6oWoPILWjK10yEsZiIXvhr4y3ZCL1u0s9x4bKVUSTMR9BZH3S5MVL6j7tTW
         Snfy0REARnrfJra9OfmViPQQz6cLSmamKZHFIBcWm927Ddj6iJIAt9aQb0bTIl7SjcC0
         BsKQ==
X-Gm-Message-State: AAQBX9d+1vPdPRChqtbWIeV11ASuQxMglgd+G4d6u/vHr6aMYZqyo6Wz
	34JR0vjEazAMUZJI883ArxQTz2OLkS2FvA==
X-Google-Smtp-Source: AKy350a/TpGwPjK4eG5I9z8srTSBg7moiouew8UMd6EC3OadXsDiSBSG5EsqYwgwxRLuJPXyjPY01g==
X-Received: by 2002:a05:6808:68c:b0:38e:80be:aa3d with SMTP id k12-20020a056808068c00b0038e80beaa3dmr5482378oig.1.1682292950621;
        Sun, 23 Apr 2023 16:35:50 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id d13-20020a05680805cd00b0038e34b0a0ecsm4003793oij.8.2023.04.23.16.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Apr 2023 16:35:50 -0700 (PDT)
Message-ID: <6b37d3b8-2f06-6e68-fa3d-1219298f6674@gmail.com>
Date: Sun, 23 Apr 2023 18:32:11 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] ft: fix double free when disconnecting mid-FT
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230419203033.26365-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230419203033.26365-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/19/23 15:30, James Prestwood wrote:
> If IWD gets a disconnect during FT the roaming state will be
> cleared, as well as any ft_info's during ft_clear_authentications.
> This includes canceling the offchannel operation which also
> destroys any pending ft_info's if !info->parsed. This causes a
> double free afterwards. Knowning this, check the status of the
> ft_info and only free if it has been parsed.
> 
> Log and crash backtrace below:
> 
> iwd[488]: src/station.c:station_try_next_transition() 5, target aa:46:8d:37:7c:87
> iwd[488]: src/wiphy.c:wiphy_radio_work_insert() Inserting work item 16668
> iwd[488]: src/wiphy.c:wiphy_radio_work_insert() Inserting work item 16669
> iwd[488]: src/wiphy.c:wiphy_radio_work_done() Work item 16667 done
> iwd[488]: src/wiphy.c:wiphy_radio_work_next() Starting work item 16668
> iwd[488]: src/netdev.c:netdev_mlme_notify() MLME notification Remain on Channel(55)
> iwd[488]: src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
> iwd[488]: src/netdev.c:netdev_link_notify() event 16 on ifindex 5
> iwd[488]: src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
> iwd[488]: src/netdev.c:netdev_deauthenticate_event()
> iwd[488]: src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
> iwd[488]: src/netdev.c:netdev_disconnect_event()
> iwd[488]: Received Deauthentication event, reason: 6, from_ap: true
> iwd[488]: src/station.c:station_disconnect_event() 5
> iwd[488]: src/station.c:station_disassociated() 5
> iwd[488]: src/station.c:station_reset_connection_state() 5
> iwd[488]: src/station.c:station_roam_state_clear() 5
> iwd[488]: double free or corruption (fasttop)
> 
> 5  0x0000555b3dbf44a4 in ft_info_destroy ()
> 6  0x0000555b3dbf45b3 in remove_ifindex ()
> 7  0x0000555b3dc4653c in l_queue_foreach_remove ()
> 8  0x0000555b3dbd0dd1 in station_reset_connection_state ()
> 9  0x0000555b3dbd37e5 in station_disassociated ()
> 10 0x0000555b3dbc8bb8 in netdev_mlme_notify ()
> 11 0x0000555b3dc4e80b in received_data ()
> 12 0x0000555b3dc4b430 in io_callback ()
> 13 0x0000555b3dc4a5ed in l_main_iterate ()
> 14 0x0000555b3dc4a6bc in l_main_run ()
> 15 0x0000555b3dc4a8e0 in l_main_run_with_signal ()
> 16 0x0000555b3dbbe888 in main ()
> ---
>   src/ft.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> v2:
>   * This was missing the check for the offchannel_id as well. If there is
>     not a current offchannel operation the info needs to be freed as
>     well (not only when info->parsed == true).
> 
> diff --git a/src/ft.c b/src/ft.c
> index 8ae683a7..e7794bf5 100644
> --- a/src/ft.c
> +++ b/src/ft.c
> @@ -1175,6 +1175,7 @@ static bool remove_ifindex(void *data, void *user_data)
>   {
>   	struct ft_info *info = data;
>   	uint32_t ifindex = L_PTR_TO_UINT(user_data);
> +	bool need_free = info->parsed || !info->offchannel_id;

If offchannel_id is true, then info->parsed is false, no?

>   
>   	if (info->ifindex != ifindex)
>   		return false;
> @@ -1183,7 +1184,15 @@ static bool remove_ifindex(void *data, void *user_data)
>   		offchannel_cancel(netdev_get_wdev_id(netdev_find(ifindex)),
>   					info->offchannel_id);
>   
> -	ft_info_destroy(info);
> +	/*
> +	 * If we hadn't yet got an authenticate response or there was something
> +	 * wrong with parsing (i.e. !info->parsed) the offchannel destroy
> +	 * callback will end up destroying the info. Otherwise we need to
> +	 * destroy it here.
> +	 */
> +	if (need_free)
> +		ft_info_destroy(info);
> +

So I would write this as:

if (info->offchannel_id)
	offchannel_cancel
else
	ft_info_destroy(...);

However, I'm pretty sure this patch is not fixing anything but just trading one 
double-free for another.  offchannel_cancel results in ft_authenticate_destroy 
being called, which in turn results in l_queue_remove().  remove_ifindex() is 
called from inside l_queue_foreach_remove(), and you can't call l_queue_remove() 
on the same queue inside the foreach callback.

Regards,
-Denis
