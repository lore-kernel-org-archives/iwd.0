Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEF36AAA
	for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 16:22:28 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-142306beb9aso2676559fac.11
        for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 08:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sZoi8mDSYf8cUjG90i3+0HnEFA2MLAb/aa7zafrIZGs=;
        b=Y3yqmCsQ0IDpflTrnXo3upMB99lBPveSj+gdM3U1Zt3xIayWdJqLPqBvDPEGLDodH7
         4pw1uC8zYU93fkUqfMpw/Reaw4VBFjWktU8kR/8hBGBX/8O9KKYn+lmBn5ZChxGHP4J6
         Ozy0XhN7BTQOe6e2JLrc7VeerKPc3HCyEtjds5dfUUSUck0+saW5xMVuzdqa/rjn0Bwp
         R4NensVO5UMlsm3GMw1tWd7e+dqrnFAg8TTZbuniwn9lftrTv6UMZtTHPNy5WAefpCc8
         4rGSSiaZQV4vQI3EcRcnNmR4bpWWESjInxznt5gQyZPInxFC3r52XJmiG829p0AiUph8
         PgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZoi8mDSYf8cUjG90i3+0HnEFA2MLAb/aa7zafrIZGs=;
        b=fd84GqSNZxCzHFwO31Nrt/8oy2GhW/Tm4gjQ2lmeCpNknsGkk03iqGadlkzW5TY+rp
         +hcT0bq4q+8xqGt4jzW4EbLwejPZx4bzlbTUNSFo7bEMi+M0GR1FKOdhy5gYfm9MwT0L
         ReCF8Zrw+PeJKsdfAEWzoEL63C5tvC6guCTOYCWZ3+aOIJdbXBcSkYdQN9YBPH08BLZq
         Yoi38vtzlAdbTYDH210Ebi0JbAAEoP8wr3rp0GvIW6GMi+niq7gElcU7ft1QpgsU19yC
         JL9Gf53W1iQ+6wX12j7nYKr+7KgXOSahaHAvR4BJ32EOeFbpVAPWyJ8nZgNzmMSLDQAR
         SUpg==
X-Gm-Message-State: ANoB5pl9QvD0uI6BeiVjBLFtdVgYijkP1pRIsCY2vmicXoo0WjjNs9oB
	TPo+CLmdc6zY2B9AVygR2PQ=
X-Google-Smtp-Source: AA0mqf70qyjYkR5gLg5LFSv6UAeZXvPd0UlMd6FNRF5uwUVwtYJlfeu3AkOApeSveCqLwJQvkdwFfQ==
X-Received: by 2002:a05:6870:959e:b0:13b:c9b3:1508 with SMTP id k30-20020a056870959e00b0013bc9b31508mr4883659oao.236.1668702147610;
        Thu, 17 Nov 2022 08:22:27 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id c29-20020a056830349d00b0066c4092ae4csm502270otu.10.2022.11.17.08.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 08:22:25 -0800 (PST)
Message-ID: <07fa9887-2391-9471-e37a-4fab1d2067fe@gmail.com>
Date: Thu, 17 Nov 2022 10:22:23 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] station, eapol: Set up eap-tls-common for session
 caching
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20221117135610.1162965-1-andrew.zaborowski@intel.com>
 <20221117135610.1162965-3-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221117135610.1162965-3-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 11/17/22 07:56, Andrew Zaborowski wrote:
> Use eap_set_peer_id() to set a string identifying the TLS server,
> currently the hex-encoded SSID of the network, to be used as group name
> and primary key in the session cache l_settings object.  Provide pointers
> to storage_eap_tls_cache_{load,sync} to eap-tls-common.c using
> eap_tls_set_session_cache_ops().  Listen to Known Network removed
> signals and call eap_tls_forget_peer() to have any session related to
> the network also dropped from the cache.
> ---
>   src/eapol.c   |  6 ++++++
>   src/station.c | 28 ++++++++++++++++++++++++++++
>   2 files changed, 34 insertions(+)
> 

<snip>

> @@ -5139,6 +5159,12 @@ static int station_init(void)
>   
>   	watchlist_init(&event_watches, NULL);
>   
> +	eap_tls_set_session_cache_ops(storage_eap_tls_cache_load,
> +					storage_eap_tls_cache_sync);
> +	known_networks_watch = known_networks_watch_add(
> +						station_known_networks_changed,
> +						NULL, NULL);

This requires a dependency between station and known_networks module since the 
watchlist is initialized in known_networks_init.  I added this in a follow on 
commit.  Please have a look.

> +
>   	return 0;
>   }
>   

All three applied, thanks.

Regards,
-Denis
