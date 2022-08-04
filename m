Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56065387
	for <iwd@lists.linux.dev>; Thu,  4 Aug 2022 19:35:41 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id h125so494639oif.8
        for <iwd@lists.linux.dev>; Thu, 04 Aug 2022 12:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=VZq5S1dFAoIHRHbmSphkLLgFFb0nUWte7gIy5f+t/vY=;
        b=HqmN1vPL3QjVSuxJitS4oA0RMxI0+aCxpCdiN0rWuZ9bJcf2KOar+HEMOHF3nxsTHv
         K+s+CKZ2E5AjI2CsJsLl0MfM7tkjb2vmBZtVHtkNP7uPvUhxB8Md7cbqe/egNGkIIeAW
         pBODbKhWuN/jnp5Cawmv7jb+3DlB7kngHHO4hJGY9WmYXvJawfez0NZp0AKWpmlumzMT
         lDB/TJglHDpfgZz4o0mkVVu6x+hJpas9zkdta4f3QA6oOPAwMQEx4zfNxCEcdvy7lthr
         NNOL996+433KMz/hNqmU78glULRKfS04+5pM7//lzIys6tzmbRjipZwQ6f8SUbgsOJQs
         Fz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=VZq5S1dFAoIHRHbmSphkLLgFFb0nUWte7gIy5f+t/vY=;
        b=Q9y4Xrin6zXtGcCeXebLimM76wF8Z5SbA9UhXo+pnUnYkZZhIfqc1KeB8H1BljH6g1
         Dd+UNFx9ISlHE9WGzqb5h5Opzx8AlV2/lIyfgln1ExWAjDSo1Ocxs/BuNNxnxyQjOwPG
         ynbOj9pcvO1TVi2mUNx+IYfCE+jdHzqONLqdbfc3SW9xjDAo6kaHLrbidLVpPd6nYORj
         9G2UVDEmsEJT2Q+QmDGeRkae0VN4Rizo+giKgaMxsULJe+WdSd1HTEACPVLQIiZ8I3Ua
         uSKYUvm/qmK65PW7HskoTozRWJXOA5bPTRjGVJnwDL3HQoLRk8A7FlLe7dsxRCvy/a+c
         D0mw==
X-Gm-Message-State: ACgBeo0ZIBIowQsnuToTaFMTrwDmwzHS/k50cRpk72vFKNJ9yTOJH0VM
	x/GcfU6RNxxZGDkaOANNmt4=
X-Google-Smtp-Source: AA6agR66Q+9CbJCcCiWLw5Q7WL/yjQokawcXQuErTGekPsM8LC3Xrh9aNm5ejTEdmU5So1JgagTKUQ==
X-Received: by 2002:a05:6808:a84:b0:33a:98f4:c7a5 with SMTP id q4-20020a0568080a8400b0033a98f4c7a5mr1531857oij.72.1659641740664;
        Thu, 04 Aug 2022 12:35:40 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id cp9-20020a056830660900b006369d5d6372sm283782otb.50.2022.08.04.12.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 12:35:40 -0700 (PDT)
Message-ID: <c2f242e0-6a6c-2cf5-ee61-3e286a72d47c@gmail.com>
Date: Thu, 4 Aug 2022 14:20:01 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 4/7] station: do full passive scan if 6GHz is supported
 but disabled.
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220804185112.457670-1-prestwoj@gmail.com>
 <20220804185112.457670-4-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220804185112.457670-4-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/4/22 13:51, James Prestwood wrote:
> The kernel handles setting the regulatory domain by receiving beacons which
> set the country IE. Presumably since most regulatory domains disallow 6GHz
> the default (world) domain also disables it. This means until the country
> is set, 6GHz is disabled.
> 
> This poses a problem for IWD's quick scanning since it only scans a few
> frequencies and this likely isn't enough beacons for the firmware to update
> the country, leaving 6Ghz inaccessable to the user without manual intervention
> (e.g. iw scan passive, or periodic scans by IWD).
> 
> To try and work around this limitation the quick scan logic has been updated
> to check if a 6GHz AP has been connected to before and if that frequency is
> disabled (but supported). If this is the case IWD will opt for a full passive
> scan rather than scanning a limited set of frequencies.

I tweaked the patch header and re-flowed the description to keep gitlint happy.

> ---
>   src/station.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 68 insertions(+), 1 deletion(-)
> 
> v3:
>   * Return -EAGAIN in the case of a regdom update rather than 0. Check this
>     along with 0 in both calls.
>   * Re-worked the wiphy state event to focus only on the DONE event, and set
>     regdom_updated based on wiphy_regdom_is_updating. This avoids a switch
>     statement when its mainly the DONE event we care about.
>   * Check quick_scan_id if regdom update so we aren't accidentally re-triggering
>     a quick scan.
> 

<snip>

> @@ -119,6 +121,7 @@ struct station {
>   	bool scanning : 1;
>   	bool autoconnect : 1;
>   	bool autoconnect_can_start : 1;
> +	bool regdom_updating : 1;

I also got rid of this bit to use wiphy_regdom_is_updating() directly.

>   };
>   
>   struct anqp_entry {

<snip>

> +static void station_wiphy_watch(struct wiphy *wiphy,
> +				enum wiphy_state_watch_event event,
> +				void *user_data)
> +{
> +	struct station *station = user_data;
> +	int ret;
> +
> +	station->regdom_updating = wiphy_regdom_is_updating(wiphy);
> +
> +	if (event != WIPHY_STATE_WATCH_EVENT_REGDOM_DONE)
> +		return;
> +
> +	/*
> +	 * The only state that requires special handling is for
> +	 * quick scans since the previous quick scan was delayed until
> +	 * the regulatory domain updated. Try again in case 6Ghz is now
> +	 * unlocked (unlikely), or advance to full autoconnect. Just in
> +	 * case this update came during a quick scan, ignore it.
> +	 */
> +	if (station->state != STATION_STATE_AUTOCONNECT_QUICK ||
> +			station->quick_scan_id)
> +		return;
> +
> +	ret = station_quick_scan_trigger(station);
> +	if (ret == 0 || ret == -EAGAIN)

Since -EAGAIN shouldn't actually be possible here, I changed this to:
if (!ret)

and added an L_WARN for -EAGAIN afterwards

> +		return;
> +
> +	station_enter_state(station, STATION_STATE_AUTOCONNECT_FULL);
> +}
> +

Applied, thanks.

Regards,
-Denis
