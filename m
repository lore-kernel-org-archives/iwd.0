Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B04B31A79
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgAuFDeF"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6d7e8da5e8dso2515279a34.0
        for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 07:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701098692; x=1701703492; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4VUJWXmVySxJTQKZ5dR+LxodlkiziYzGdy24fCtImY=;
        b=SgAuFDeF70EWixMl1Hnsy/0k6KluDhzTV8OM02dajhwx8RD8nWfnkUszSJxhwTkQ8e
         YUCLgwx23vYPd+s2u2Ccf4lRpXUxpt4EbGPgA03hlWby7C4jKRpzoLH90LMxyFiZJQun
         fJiahfAmVoVmuuveWjNbGR+uNNwc7k7Ejn58h/bhTUXacOYEhFf1rhJdFwmysxCZCMH8
         N/r+snxDhtUnQohqT57Rk80al/323PHQQjGyLQmq2epmkIR09C75Gt027g21J752C5DX
         +sIPG1RKCXGk+JSD7AgfA+QdZVH0SDMxifSuqNfXCTl2yS3YiptQCW6cgvYGj5OtGe3r
         iIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098692; x=1701703492;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4VUJWXmVySxJTQKZ5dR+LxodlkiziYzGdy24fCtImY=;
        b=lOSVmEyFtlpRjRAwU+cdnFPBUylUMGfJlqlxYJco6J77eOH2UbELNmUnYdqZ7ulyRm
         a9wHKzr/DDs6kD3xaX0STv2nnhbbeWyNnQxO/8pgMk8lrMBHlgkQxW4mBSx9+TJdbFPI
         KmHC4AaZ7pZs17YMjAWlYmfS8JfhvYk3ix2Gkr8GMUuaT1+5I9QL4zm+WcTLOSK07ZGJ
         iLBTRf6W6RcWvlMblcNQe9OKDTjhPam2ocp3tSQIA/wXFYnxOVyqWFxD6jsgY1vEhTtS
         J9fUpsmMu9bvN5+1tsEmhOEWAG0fzjdIvsfW395N/LATNEUz0bz6cvyyInwbJlnx7Vgh
         Q9jA==
X-Gm-Message-State: AOJu0Yz4nwE5O28tUyvDUBJM1iW6UPOFmRL1VL6KgRhCzUwwcxZEtE7y
	D3h6BQhZQ+PyQbibTDS/Ugg=
X-Google-Smtp-Source: AGHT+IGZ+yo7yKjhY8CLRLxxB66hL2+nTmlS0XTrsE2JMvxPjsdUsuT6gmlZCti8tOJaAAKcfLmy1w==
X-Received: by 2002:a05:6820:168d:b0:58d:a202:5bdd with SMTP id bc13-20020a056820168d00b0058da2025bddmr1228289oob.9.1701098692411;
        Mon, 27 Nov 2023 07:24:52 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 63-20020a4a1442000000b0058a2872d1d6sm1598106ood.42.2023.11.27.07.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 07:24:52 -0800 (PST)
Message-ID: <41e2fc45-adaa-442c-a912-5e46096ab14e@gmail.com>
Date: Mon, 27 Nov 2023 09:24:51 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] station: fix crash when deauth comes before FT work
 completes
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231127124947.273760-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231127124947.273760-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/27/23 06:49, James Prestwood wrote:
> If the FT-Authenticate frame has been sent then a deauth is received
> the work item for sending the FT-Associate frame is never canceled.
> When this runs station->connected_network is NULL which causes a
> crash:
> 
> src/station.c:station_try_next_transition() 7, target xx:xx:xx:xx:xx:xx
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 5843
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 5844
> src/wiphy.c:wiphy_radio_work_done() Work item 5842 done
> src/wiphy.c:wiphy_radio_work_next() Starting work item 5843
> src/netdev.c:netdev_mlme_notify() MLME notification Remain on Channel(55)
> src/ft.c:ft_send_authenticate()
> src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Status(60)
> src/netdev.c:netdev_link_notify() event 16 on ifindex 7
> src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
> src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
> src/netdev.c:netdev_deauthenticate_event()
> src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
> src/netdev.c:netdev_disconnect_event()
> Received Deauthentication event, reason: 7, from_ap: true
> src/station.c:station_disconnect_event() 7
> src/station.c:station_disassociated() 7
> src/station.c:station_reset_connection_state() 7
> src/station.c:station_roam_state_clear() 7
> src/netconfig.c:netconfig_event_handler() l_netconfig event 2
> src/netconfig-commit.c:netconfig_commit_print_addrs() removing address: yyy.yyy.yyy.yyy
> src/resolve.c:resolve_systemd_revert() ifindex: 7
> [DHCPv4] l_dhcp_client_stop:1264 Entering state: DHCP_STATE_INIT
> src/station.c:station_enter_state() Old State: connected, new state: disconnected
> src/station.c:station_enter_state() Old State: disconnected, new state: autoconnect_quick
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 5845
> src/netdev.c:netdev_mlme_notify() MLME notification Cancel Remain on Channel(56)
> src/wiphy.c:wiphy_radio_work_done() Work item 5843 done
> src/wiphy.c:wiphy_radio_work_next() Starting work item 5844
> 
> "Program terminated with signal SIGSEGV, Segmentation fault.",
> "#0  0x0000565359ee3f54 in network_bss_find_by_addr ()",
> "#0  0x0000565359ee3f54 in network_bss_find_by_addr ()",
> "#1  0x0000565359ec9d23 in station_ft_work_ready ()",
> "#2  0x0000565359ec0af0 in wiphy_radio_work_next ()",
> "#3  0x0000565359f20080 in offchannel_mlme_notify ()",
> "#4  0x0000565359f4416b in received_data ()",
> "#5  0x0000565359f40d90 in io_callback ()",
> "#6  0x0000565359f3ff4d in l_main_iterate ()",
> "#7  0x0000565359f4001c in l_main_run ()",
> "#8  0x0000565359f40240 in l_main_run_with_signal ()",
> "#9  0x0000565359eb3888 in main ()"
> ---
>   src/station.c | 3 +++
>   1 file changed, 3 insertions(+)
> 

Applied, thanks.

Regards,
-Denis

