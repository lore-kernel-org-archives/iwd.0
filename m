Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0056194
	for <iwd@lists.linux.dev>; Wed,  9 Nov 2022 20:45:25 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso58013otb.2
        for <iwd@lists.linux.dev>; Wed, 09 Nov 2022 12:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/gAEFWtPmbjezRn0MouQKn/on7avpOemzc3JbUA/O0=;
        b=ERs/o9gm4eTODAnRkXVlOECNjXGheTp5lp9ZDDrsXPyMPwqKVjqgZhIYO6ng/n4YS4
         3vTTtxJx4IVlOZ+1qcP+EAeClCHRbbM3tJr/JWvt+8oae0x+Wd3qOuaz28Ha7Vu/tZFC
         b5yQxhkhgq3LhI2/sA6drkpUwD/Y/s2efqKhK+0tdC6njnZHQiMPmmIs6IaqmwpMoQp1
         NtiC6Z5Zo0iLbg6dlyEY1J8AVHWtQv9sWNsH/tICHQvSSDReub0vQcrzIEOIcD84AYDu
         MKz0dcpYIXS2SHtn+liW7xx6WAYAf8ZhTkEvyGewcuSCQcfKPIu+xqusIOWjYpQWIWGO
         KB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/gAEFWtPmbjezRn0MouQKn/on7avpOemzc3JbUA/O0=;
        b=h8Q9gJwxlIvGW7wL9jKTvm/vZ7CbHs5OmqSGqNEYzgHZ0Ci7J+F3c7OL3GSO2Z9vas
         16QUzL05TIqSuICbkF/BX18/HqAh099hq6zsUczzQqALTS2J4sDw0CWJ+qvAV7HGbQon
         v1wuPandBccIJGgoGoCQKr17C3UqC1hqYPsZm4ch6ktEnSA13pz6q+ameSWyOh1TfAjZ
         OZQEvDmcUefNSmRHOykVrQk0a4u5WQR9cHZN2fe0pPqQl3OkH2vPfJMfJcYqpUrdjD5k
         gFxZ8b6aMMd4AgOIifPhqUZL7HPGmC1r97EbYHlOzolt9ig7K600x9hU+SsKhANS5sTD
         6QzQ==
X-Gm-Message-State: ACrzQf0wxzPPLvmpOJWjDTF0vac7z25gG7l0dkCouJgnOyU4l/sOhYBu
	nZDjbJSghbYvjIFU9sXTUbTXKv9Mhg4=
X-Google-Smtp-Source: AMsMyM5/77TE+hwHsh8Nvbb1cyUi4jaNz/OmpM8M6zv/WvD0UNXZsKnfVtoVMRdYusJQ4Ez6VGVjww==
X-Received: by 2002:a9d:4c95:0:b0:66a:2197:537c with SMTP id m21-20020a9d4c95000000b0066a2197537cmr29208986otf.148.1668026724935;
        Wed, 09 Nov 2022 12:45:24 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y18-20020a056830209200b0066cf6a14d1asm3459297otq.23.2022.11.09.12.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 12:45:24 -0800 (PST)
Message-ID: <e7035cb1-17d0-22e5-3bfa-4e6515e2b4c9@gmail.com>
Date: Wed, 9 Nov 2022 14:45:23 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] eap-tls: Add session caching
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20221109170438.535300-1-andrew.zaborowski@intel.com>
 <20221109170438.535300-2-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221109170438.535300-2-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 11/9/22 11:04, Andrew Zaborowski wrote:
> Use l_tls_set_session_cache() to enable session cache/resume in the
> TLS-based EAP methods.  Sessions for all 802.1x networks are stored in
> one file, /var/lib/iwd/.tls-session-cache, indexed by the EAP method
> name and authenticator's MAC/BSSID (handshake->aa) because that's
> ultimately what identifies the authenticator which will usually be the
> TLS server as also.  We may want to add the SSID to the index.  Multiple
> BSSes and even multiple ESSes (SSIDs) may be backed by a single
> authentication server but it's hard for us to know that.

But isn't the TLS session ultimately out to the RADIUS server?  So wouldn't the 
session id be identical between the entire ESS/SSID?  I also don't see the need 
to store the EAP type here as well.  We can't have SSIDs with multiple EAP types.

This does however bring up another point.  Shouldn't you clear out the cache 
when a network is forgotten?  In which case, how do you reload the cache in the 
EAP module?

> 
> eap_{get,set}_peer_id() API is added for eapol to set the identifier of
> the authenticator (or the supplicant if we're the authenticator, if
> there's ever a use case for that).

Okay

> 
> eap-tls-common.c can't call storage_tls_session_cache_{load,sync}()
> directly because it's linked into ead and some unit tests without
> storage.c, so station.c sets pointers to the load & sync functions using
> the new eap_tls_set_session_cache_ops().

ead should probably start using storage.c anyway since that does profile 
encryption and we ultimately want that inside ead as well.  But we can solve 
this later.

> ---
>   src/eap-tls-common.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
>   src/eap-tls-common.h |  6 +++++
>   src/eap.c            | 13 +++++++++++
>   src/eap.h            |  3 +++
>   src/eapol.c          |  4 ++++
>   src/station.c        |  6 +++++
>   6 files changed, 84 insertions(+)
> 

<snip>

> @@ -633,6 +645,26 @@ static bool eap_tls_tunnel_init(struct eap_state *eap)
>   	if (eap_tls->domain_mask)
>   		l_tls_set_domain_mask(eap_tls->tunnel, eap_tls->domain_mask);
>   
> +	if (!eap_tls_session_cache_load)
> +		goto start;
> +
> +	if (!eap_tls_session_cache) {
> +		eap_tls_session_cache = eap_tls_session_cache_load();
> +
> +		if (!eap_tls_session_cache) {
> +			eap_tls_session_cache = l_settings_new();
> +			l_debug("No session cache loaded, starting with an "
> +				"empty cache");
> +		}

Can we run into a situation where we have two TLS sessions running with the same 
cache entry and it is invalidated somehow?  Do we need to notify the other TLS 
sessions somehow?

Perhaps if we're running a multi WLAN setup and both are connected to the same SSID?

> +	}
> +

Regards,
-Denis
