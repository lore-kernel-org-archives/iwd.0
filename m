Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559E532F770
	for <iwd@lists.linux.dev>; Wed, 29 Jul 2026 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785358968; cv=none; b=vDHPJWJfYTjt+uqGyYc0NWCKra6Tk4ZBog/kU2aGUZ70P1eR0o21EDyVBs1SMW8n/t09pLcifkNtxNWIv75vy7l5jU/YzMnuOnhIeb8ZLXDdiQfnl+P7nPG6upluo9eYAT+xnZt35GE8AsTJtHCiMzi/Hjnhvrv1oZF4n76laRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785358968; c=relaxed/simple;
	bh=UszQjXy+LViPqIebMdFs3mXKOMVaTzc46iVBV6jv9xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IutQJhF1vg+bJEKyknh7x9lIX2nCVAm8ggCoG8TCmZKmrJGSExRSOfWX1XlJ1h4FLnOVXY4C/hmbTMkYSPylhJzR5kT5TIS80lpxMiFplPcFjNDMoN9vOyg+WNqS9zu6A1pTNrTSL5f19ygzH1xE/8d/++U0bQUzQK7ZGS2Du6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHSDE2+f; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHSDE2+f"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc891373e0so16883485ad.2
        for <iwd@lists.linux.dev>; Wed, 29 Jul 2026 14:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785358966; x=1785963766; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RxHF0HjGZyGfZNNs8+XZlegZ4xl3wQcJinvhPnX+ROo=;
        b=lHSDE2+fHTStpAtSqhMDyrwJW7YPgnBzr2QdvpAOlJcMcw/dK7+EeaoCglvdeLmBdH
         cnqD9iioYTop95nIi/2/oFoBi8lRPnz/49pWTQk7PN3usu3wRrRAeEB7SH53xqJx2sNV
         irpa+yU/caPHRq7RnmIqiVkDC983RDQSwbsUEx8kE53raLxE4rWJUaeUdnZWzzRumVrA
         +3eDcsRXUD3rAyq2oQPZd1pDppaH+zH609SB2bX4uzVA/A5FsyYwLTLeFsHc+P4U/4Gl
         ZHVtbzvY2v9WBFScFcDnUziATdlfcC78BRl/IE7eP0CZGaHYKL0Ad2GASB6npHVEPtWD
         0ASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785358966; x=1785963766;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RxHF0HjGZyGfZNNs8+XZlegZ4xl3wQcJinvhPnX+ROo=;
        b=TPiPYA7BLY4upNyyutQ++d6jSrApU7/7yGJufla3YI/d8JpV388lumrapZsJuu6Q/e
         aI38fxoA3HoIEIf3vZeizpflLFORaFvdLkqTh4Ug7r9U4MCv7z798OoM/oSlqipo165I
         E01YmYu/jDuZqhURm0LmCUGldvrGa36/SXXAJYVdl+rLK9J0fwXYPvLYgOQ3xl8l7PHt
         xFHBfxbiHDFKrtJ5nFS8jO5jkcdJNyaG3khakf6kpkpApQcf1Fra/7pmjCxWtX4AkDSx
         Ia23aOpRdBFn0Ytnvz9gpJvQ3a0Vypb6+iv4olY+EWMyo2KiQHWQfeB51xm7SJG3xSvH
         1NeQ==
X-Forwarded-Encrypted: i=1; AHgh+RqDdEzWQxZa8Q9GKAHlEzeUJ76y8FZBM5MXDuab4Lk2etY3S4AIq6lWXkgZz0481xHp4zA=@lists.linux.dev
X-Gm-Message-State: AOJu0YwZL+GxqcG9NpC1Pg3q1TwpJd31iTZyM9eyELHVHCCg5jtD1ECZ
	ePDwJaYhX3XQJlllREwfMM7JCJf6LW3q2xhkrrXVUQnczYuX44Vtx69F
X-Gm-Gg: AR+sD13atJ2UiFkAZCt6nGFuKO0l/0nWiNV6TnB468FWxdDadu7A32RvlwFbNjVDo6M
	DB0TsrEXQUUI2J4VWGCJCSBD7XTuMwASS6EBM4EBj4PHJz3to0vfMgc+s9XUZ92O29iO0NqKd70
	8+oRhmrc5zaaqhlOmeSFBPX1jizGK2Bkt/blGLTSMVADoNlsWBfsDcV5xWQSIlmU1a6XiD6YHMK
	cAbzyw5B6Gj9Gd2RiE1ij7zLfItrjAJGb+DtMK+8tH0jC/xWYFI+y+YaCwMhcODJ+lkl0OwLEs5
	Fbkkk92Zl8haaUyM3/B7YfsRbv16uyJk5++ZvkIWsZlcgez2DjYpS9Kh/tlRnQNjaKm+4Eo1/YL
	ANvCQagUu+fVoEgbYG99IAiccqsT7vyANshAcDAW6wqR/AS9ONu9oSsatAEITnw4kZciqC/VymM
	cYBmnu739pRMyT4p6lBe+Zkh5yAHqE0M66dEUoPzelSfgiaFtrP7FUeQPiAPjDtnfUevKUlG9Es
	9mZX59RwbpSmSHq+v1ResRNaNjq3HXGNw==
X-Received: by 2002:a05:6300:67c8:b0:3c0:9c19:659b with SMTP id adf61e73a8af0-3c8ba639873mr10370721637.67.1785358965479;
        Wed, 29 Jul 2026 14:02:45 -0700 (PDT)
Received: from [10.202.22.105] ([50.170.192.18])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba63f806sm1414522a12.23.2026.07.29.14.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 14:02:44 -0700 (PDT)
Message-ID: <389bb3fd-d33a-4dd4-a494-a81eb9dbd03e@gmail.com>
Date: Wed, 29 Jul 2026 14:02:42 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netdev: Fix premature ECSA channel switch timeout for
 mt7925
To: arpan <arpanpramanik015@gmail.com>, iwd@lists.linux.dev
References: <20260729201316.85499-1-arpanpramanik015@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20260729201316.85499-1-arpanpramanik015@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Arpan,

On 7/29/26 1:13 PM, arpan wrote:
> The mt7925 cards get stuck and disconnect during Extended Channel Switch
> Announcement (ECSA) events because the kernel considers them stuck.
>
> This occurs because the kernel sends an imminent channel switch
> notification (NL80211_CMD_CH_SWITCH_NOTIFY with the
> NL80211_ATTR_CH_SWITCH_COUNT attribute present) prior to the physical
> switch. iwd was previously ignoring the countdown attribute and
> immediately initiating an active scan to re-query the AP. Sending a
> scan command while the firmware is trying to tune the radio causes the
> mt7925 firmware to time out.
>
> This patch adds a check to see if the countdown attribute is present for
> mt7925 interfaces. If it is, we wait for the second notification (which
> omits the count) that confirms the switch is physically completed before
> proceeding with the internal state updates.
>
> Signed-off-by: Arpan <arpanpramanik015@gmail.com>
> ---
>   src/netdev.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/src/netdev.c b/src/netdev.c
> index e639a1f8..96b48ac3 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -5428,12 +5428,32 @@ static void netdev_channel_switch_event(struct l_genl_msg *msg,
>   {
>   	_auto_(l_free) struct band_chandef *chandef = NULL;
>   
> +	uint32_t count;
> +	const char *driver;
> +
>   	if (netdev->type != NL80211_IFTYPE_STATION)
>   		return;
>   
>   	if (L_WARN_ON(!netdev->connected))
>   		return;
>   
> +	driver = wiphy_get_driver(netdev_get_wiphy(netdev));
> +
> +	/*
> +	 * If the channel switch countdown is present, the switch is imminent
> +	 * but has not happened yet. Wait for the second CH_SWITCH_NOTIFY
> +	 * event (which omits the count) to avoid interrupting the firmware
> +	 * by prematurely starting a scan.
> +	 *
> +	 * Restrict this workaround to mt7925 cards as requested.
> +	 */
> +	if (driver && !strncmp(driver, "mt7925", 6) &&
> +			nl80211_parse_attrs(msg, NL80211_ATTR_CH_SWITCH_COUNT, &count,
> +				NL80211_ATTR_UNSPEC) == 0) {
> +		l_debug("Channel switch imminent in %u TBTTs, waiting...", count);
> +		return;
> +	}
> +
>   	chandef = l_new(struct band_chandef, 1);
>   
>   	if (nl80211_parse_chandef(msg, chandef) < 0) {

My only confusion is why this attribute is used with 
NL80211_CMD_CH_SWITCH_NOTIFY since its not indicated as such in the 
nl80211 docs. It does mention the attribute with 
NL80211_CMD_CH_SWITCH_STARTED_NOTIFY though. Would you be able to 
capture iwmon logs so we can see the sequence of events, maybe there's 
some details hidden in there.

Based on the documentation for NL80211_CMD_CH_SWITCH_NOTIFY:

"This indication may also be sent when a remotely-initiated switch 
(e.g., when a STA receives a CSA from the remote AP) is completed;"

I read this as the channel switch is done, and userspace just needs to 
be informed. Not the behavior here where its _started_ and you need to 
wait for it to complete...

Maybe this is a specific behavior of the mt7925 (which would be 
unfortunate) but in general we'd like to avoid driver specific 
workarounds if at all possible.

Thanks,

James

