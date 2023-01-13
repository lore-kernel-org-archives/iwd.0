Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A3E2F2A
	for <iwd@lists.linux.dev>; Fri, 13 Jan 2023 15:55:53 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id f5-20020a9d5f05000000b00684c0c2eb3fso3387059oti.10
        for <iwd@lists.linux.dev>; Fri, 13 Jan 2023 07:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YXka5LK2BOPkPr7OgAbWsx1A60mWBlzCRCMRO1v5TlY=;
        b=akVxPr86ViXBVne9SCjyDtxcATt8XPzWG27rLemFA3VgoHdF0+KY4aGQZIpYm2qySU
         n5iJSG6J3H4OA448/6fep1/0ZnlQlAFnYjLQXehGTNC3VhhtJN6iysT4O/cZ/s1EhU6M
         Qy56ZuePoV4IIjfBholO3ORgC+A31awyeYU0SWCJg6zIZNvebLSbsJu0fHkOWH47RePy
         U9JbpqYr0yixrLrDwj6kUbjSMjGVKdBbkESXVlSz3tDfg0jtG0bDGSfKSeDDsptKMjyH
         HoMIGWyx1fP+Bj8cIwIKKsbObzBFotv+fRE2OhrIhb/txyb0+0pCgwuLtH2hpNTzza/Q
         L14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXka5LK2BOPkPr7OgAbWsx1A60mWBlzCRCMRO1v5TlY=;
        b=j+k/62G4S2iYavb5I//RDYueEWZEQacYfTfO+4ltEvOpR4kcUckhDl+ApPY5w485WE
         rzsQMUhioHGO76HmHI3g8pJAz5o5ueShhh7FKr58Iwy9bw9njthe7fgIzUjmQEy019fz
         B1Z8E6yjcjC4gLnZW6blbqvA40oz3qb0flR8upParDUTPaxlg7JBdar97gqkuQhD3OV4
         JY3PYcVW6W5QRI3f29NPKh+3NX/tBGyx5DCOi3vBugWSFi/DMsu7W5vTK/gtr5bUOuR5
         zmX8SAB2EjCOPRMVRewmcNt5vV+COxqUeE+WJ4pWZSro+1jeQz2rjeqYSJm2lzWm3hex
         ywyA==
X-Gm-Message-State: AFqh2kry3+S8+WOWjeNzFH0voV6wKbJ126lTp0BUD20j9bjjtF3N9M9B
	Iu3JXvrq7Xnj2HlmVuz04+Y=
X-Google-Smtp-Source: AMrXdXtgW7hZAALO2Nsmuos9LiQzwt05rSaUsC04vNHuIfYSb2V1n/FH+1F9DByqkEk3C/kQRyhskw==
X-Received: by 2002:a05:6830:30b1:b0:661:dfeb:ae25 with SMTP id g49-20020a05683030b100b00661dfebae25mr41009958ots.28.1673625352585;
        Fri, 13 Jan 2023 07:55:52 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id q2-20020a9d6542000000b0067088ff2b45sm10541834otl.37.2023.01.13.07.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 07:55:51 -0800 (PST)
Message-ID: <a67db660-276a-ef41-179e-bb12e7602409@gmail.com>
Date: Fri, 13 Jan 2023 09:35:09 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/4] ap: support PTK rekeys
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230112193212.568476-1-prestwoj@gmail.com>
 <20230112193212.568476-3-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230112193212.568476-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/12/23 13:32, James Prestwood wrote:
> This adds support for rekeys to AP mode. A single timer is used and
> reset to the next station needing a rekey. A default rekey timer of
> 600 seconds is used unless the profile sets a timeout.
> ---
>   src/ap.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 114 insertions(+)
> 

<snip>

> @@ -439,6 +452,89 @@ static void ap_del_station(struct sta_state *sta, uint16_t reason,
>   
>   		ap_event_done(ap, prev);
>   	}
> +
> +	ap_reset_rekey_timeout(ap);

Shouldn't you be cleaning up the timeout here?

> +}
> +
> +static void ap_start_rekey(struct ap_state *ap, struct sta_state *sta)
> +{
> +	l_debug("Rekey STA "MAC, MAC_STR(sta->addr));
> +
> +	eapol_start(sta->sm);
> +}
> +
> +static void ap_rekey_timeout(struct l_timeout *timeout, void *user_data)
> +{
> +	struct ap_state *ap = user_data;
> +
> +	l_timeout_remove(timeout);
> +
> +	ap_reset_rekey_timeout(ap);
> +}
> +
> +/*
> + * Used to initiate any rekeys which are due and reset the rekey timer to the
> + * next soonest station needing a rekey.
> + *
> + * TODO: Could adapt this to also take into account the next GTK rekey and
> + * service that as well. But GTK rekeys are not yet supported in AP mode.
> + */
> +static void ap_reset_rekey_timeout(struct ap_state *ap)
> +{
> +	const struct l_queue_entry *e;
> +	uint64_t now = l_time_now();
> +	uint64_t next = 0;
> +
> +	if (!ap->rekey_time)
> +		return;
> +
> +	/* Find the station(s) that need a rekey and start it */
> +	for (e = l_queue_get_entries(ap->sta_states); e; e = e->next) {
> +		struct sta_state *sta = e->data;
> +
> +		if (!sta->associated || !sta->rsna)
> +			continue;

Would checking sta->rekey_time == 0 also be worthwhile?  For stas that haven't 
authenticated yet?

> +
> +		if (l_time_before(now, sta->rekey_time)) {
> +			uint64_t diff = l_time_diff(now, sta->rekey_time);
> +
> +			/* Finding the next rekey time */
> +			if (next < diff)
> +				next = diff;
> +
> +			continue;

Ok, so you try to find the next soonest (absolute) rekey_time to schedule the 
next timeout.  Might be easier to just set next to ~0 and loop over the stations 
using l_time_before(sta->rekey_time, next), setting next as needed.

> +		}
> +
> +		ap_start_rekey(ap, sta);

And looks like this starts a rekey for any stations that we somehow missed?  How 
does this happen?

> +	}
> +
> +	/*
> +	 * Set the next rekey to the station needing it the soonest, or NULL
> +	 * if a single station and wait until the rekey is complete to reset
> +	 * the timer.
> +	 */
> +	if (next)
> +		ap->rekey_timeout = l_timeout_create(l_time_to_secs(next),
> +						ap_rekey_timeout, ap, NULL);
> +	else
> +		ap->rekey_timeout = NULL;

Are you sure the rekey_timeout is destroyed here?

Might be easier to use l_timeout_modify instead of creating/destroying it all 
the time?

> +}
> +
Regards,
-Denis
