Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B647F
	for <iwd@lists.linux.dev>; Mon,  1 Aug 2022 15:27:55 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-10e615a36b0so12534784fac.1
        for <iwd@lists.linux.dev>; Mon, 01 Aug 2022 08:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=WHmwfnd7HPYzTte84XIO9dPpmcbxeZLMAKdHVpNqRfA=;
        b=Mmm0bXBHMSRNYdTr2Fn677DI9j7bR7dp4poFzv7KYXgAQw1XtuCoT5lsNjcvM8VVsK
         5z7Y+rIlud4NVEQXq5ZYJmTyhE3UHnuTZl0ar8PKmWWn9Q/2QGlytYC3anV8BTZZxRwP
         jkX/z1upoxrz3Z28LTfIJhBhuAnFnWaOXMqVtSnFKwa2JBjgNlRWGd8E5gwMA61pNxdh
         GwUlSSATUA5ZmuLsmreH6GxXZoq4TUMiOe3dRwW8SYOdeup6hf8TImNGFfuqo0q2fT1q
         J22exgxIB922OHD+jsI4SA/V6QD92FeT3jupY4MrwzsRRydQxdmTWedeoRXdlA5BwnhH
         wsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=WHmwfnd7HPYzTte84XIO9dPpmcbxeZLMAKdHVpNqRfA=;
        b=OgE2dobr8E11Bm3B9+H2ihzzPD5ge26NYrgVp5iy4DBKgII/rqP1JpXBw3VKcVtf6j
         hFLOZ3v85xQit+x/AU4hu5REajh6kj1i7s+sJSQSuEF9cRbHbMBjqh7Jw1BHlx1KSpSv
         qygpHM2/qAgc8iqHlYL3KhWRpAbtyGoU1fkA5PJmotSRZ5MzH2RXVUsHsHEf7VtO1Rap
         ulf5LsoheXo6vCVz5JQsI1q7j7R6SI9rIkySr9hoCOVMGbBjzeIfKVfeguCLJrmRC3SX
         wNA3SfSj/zXOqjgLBD/Ol1U0wvLQXICycUhCUAL8yyGMP4b7HUL/eTI7OE7QdAZ4jRjy
         RXlg==
X-Gm-Message-State: AJIora9DDEKIK9N3tuJrpD9+FnELEgAa14zUJpdE7ddhr7TiQ6gfEw3U
	ojxjZsjFvc+Z8s5mbri+OzdpiXDrgvw=
X-Google-Smtp-Source: AGRyM1uQX4+8DoZcRnR/IHQ4JJXUDaRlNJXw4yms1eKnlrWrrRc7AmJedrKc/3YNHPHVlrfcHQfmYg==
X-Received: by 2002:a05:6870:c698:b0:101:fbdc:d044 with SMTP id cv24-20020a056870c69800b00101fbdcd044mr7831670oab.269.1659367674556;
        Mon, 01 Aug 2022 08:27:54 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u10-20020a056870304a00b0010d910ffc3asm3170805oau.18.2022.08.01.08.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 08:27:54 -0700 (PDT)
Message-ID: <6bc199e2-2f40-b192-9de6-30fceb2510ea@gmail.com>
Date: Mon, 1 Aug 2022 10:17:08 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] netdev: Add logging for CQM messages
Content-Language: en-US
To: Michael Johnson <mjohnson459@gmail.com>, iwd@lists.linux.dev
References: <20220801100631.41605-1-mjohnson459@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220801100631.41605-1-mjohnson459@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 8/1/22 05:06, Michael Johnson wrote:
> Add extra logging around CQM events to help track wifi status.
> 
> The signal strength logging matches wpa_supplicant's which looks like
> this:
> 
> CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-60 noise=-96 txrate=6000
> ---
>   src/netdev.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 

<snip>

> @@ -1106,10 +1120,14 @@ static void netdev_cqm_event(struct l_genl_msg *msg, struct netdev *netdev)
>   	}
>   
>   	if (rssi_event) {
> -		if (rssi_val)
> +		if (rssi_val) {
> +			l_info("Signal change event (above=%d signal=%d)",

I'm not sure 'above=%d' is going to work.  rssi_event is only set on 
THRESHOLD_EVENT_LOW/THRESHOLD_EVENT_HIGH.  If RSSI_LEVEL is being reported, that 
pointer is still NULL.

> +							*rssi_event, *rssi_val);
>   			netdev_cqm_event_rssi_value(netdev, *rssi_val);

Hmm, I don't think wpa_s uses RSSI_LEVEL stuff in the kernel, does it?  The 
reason I ask is that we do have UIs that setup RSSI level reporting for 
displaying connection link quality (in number of bars for example).  Since such 
events are quite common, I think you're going to get quite a bit of spam in the 
logs.  Are you only interested in cases where the roaming threshold is reached? 
  If so, you may need to modify netdev_cqm_event_rssi_value() instead.

> -		else
> +		} else {
> +			l_info("Signal change event (above=%d)", *rssi_event);
>   			netdev_cqm_event_rssi_threshold(netdev, *rssi_event);
> +		}
>   	}
>   }
>   

Patch 2 looks fine btw, so I applied that one.

Regards,
-Denis
