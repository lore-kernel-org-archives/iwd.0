Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D8B3222
	for <iwd@lists.linux.dev>; Sun, 30 Apr 2023 18:01:02 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6a5f21a0604so1374423a34.2
        for <iwd@lists.linux.dev>; Sun, 30 Apr 2023 11:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682877661; x=1685469661;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hvDaHizuy44spn2SSDgFw0ub5UH2r12118oM+ZCypp4=;
        b=DHEgyxFbpr7xLCyNhlSJOQas/iK1qXdKW65D3ch8XTXsX1FPobhJR3PW7wuOsLTTtv
         UFgdckfFQFMQQ6/Kq5Gsm/Pl7ESEQv7ZZ33u+j/bp+BObJBz203CGImsIY5y4SP5GuaF
         WBFxdELnRnPLfQaVsxsw/qbIPWMKQZZS4QRsGS3nTuPSHQamARlXQdTSpFDYQKNqQetW
         OsRZCBiL5LKCf4URCxkUOwXYE3TX/j0/z9Mj5sjICekDwFouks530y1J+YO0iENzNReu
         kUFJOllEevr6T9SUH/iRxxPv1Ff/lri2H66dtanHb0+HdbPfVAe+fk8HHj0YyA/FKDB3
         wSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682877661; x=1685469661;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvDaHizuy44spn2SSDgFw0ub5UH2r12118oM+ZCypp4=;
        b=hZPIQk2FXWhJuFoaLBaUp45/h9DGmAw05xzNR7K328CEGuZbDEL7jgt3JZRLu88/g9
         NPlWBKM8YzBCzP4WLVgAL2yL/IzlrZAy7/fsZHiAnhqya7alPCGvweQ4Ro/OVcV0dmR0
         U45VUqEEQdMOadpKAiWh3vPZlZcKKHmqJ2RE0LzsYQovnHB5+f1nOEH0RzETdzYBL5nf
         WNVZiObQXGxoPlz0+XGmAE5/Xw9dtduCkiTgI5fg6lEHJKdVRScEP8JLjhhek1E8pK4+
         aAvj118EeUY8HgNdVRv0BaSnd4slIlD//79Z2+h78/IeSisI5VzLA0zRvn+9nyGjStCT
         DbCA==
X-Gm-Message-State: AC+VfDyOtrZ6B6N5CY5TkDKbXabpfxmaiRBsEV0zS+CbNal/qnOurzSb
	Zjfm7SN9uvKdztzifve2+M4=
X-Google-Smtp-Source: ACHHUZ4HkFDKPcuEQwhRP4IJhaO57B+RtlEsfS7zc1zv6zjxm2p3E7b2KO0MiKekP1IcCm5OSNHlIg==
X-Received: by 2002:a05:6830:1545:b0:6a4:44f0:c94a with SMTP id l5-20020a056830154500b006a444f0c94amr6042407otp.2.1682877661343;
        Sun, 30 Apr 2023 11:01:01 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id p7-20020a9d7447000000b006a4cceaf8ecsm11400731otk.48.2023.04.30.11.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Apr 2023 11:01:00 -0700 (PDT)
Message-ID: <f347e9f6-d475-c37c-c223-1622f078dc9b@gmail.com>
Date: Sun, 30 Apr 2023 13:00:27 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] ft: fix double free when disconnecting mid-FT
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230424134033.32916-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230424134033.32916-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/24/23 08:40, James Prestwood wrote:
> If IWD gets a disconnect during FT the roaming state will be
> cleared, as well as any ft_info's during ft_clear_authentications.
> This includes canceling the offchannel operation which also
> destroys any pending ft_info's if !info->parsed. This causes a
> double free afterwards. In addition the l_queue_remove inside the
> foreach callback is not a safe operation either.
> 
> To fix this don't remove the ft_info inside the offchannel
> destroy callback. The info will get freed by ft_associate regardless
> of the outcome (parsed or !parsed). This is also consistent with
> how the onchannel logic works.
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
>   src/ft.c | 5 -----
>   1 file changed, 5 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

