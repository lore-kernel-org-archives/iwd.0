Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A0D3382F4
	for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036272; cv=none; b=J8EcuaFnbRMJBCMw30tLOmZs3zgm4o39Rmoug8KPN0WzQaWq4WI9efp2dB8FGhHxlmzwTg/8uo9YQLBkOIBj9VmnHbfKmiAllLflCKqXMcMlAgh6bz+SfyGTK7HhfMlizP+6UKr3Um02idaTPcsIYR32dMSI9ui2gRS+Gw7ph2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036272; c=relaxed/simple;
	bh=0TVoULlSRLwtMVZGrF5HimaAtmYysO9MCDBt75inuwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MU1nPMEjczDR2dG0WKHIrpM8lFRzUsilRZ2i6dJIW7OZ8cQ5UIA1yJN0KyW2CBjQfwZOS18R4AeZWymsJqQ2iVq1ZFyUwYaFrpsnxAvZ6ADo3VtWbVncbZbbtg0Z7hPZCazowCMGXZ1vTFbUW+gDXAlTElt1f/Ko8GZa2wojaG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeYxQhEH; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeYxQhEH"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1006057a91.0
        for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 06:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784036270; x=1784641070; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=emlgPvqXL1rZ/dk2g2h33xQdXZOEmYyk1lxLipg2WQk=;
        b=VeYxQhEHafIinMKAGyzT1ECYh5Id26n/6SMYVo12+GoqZkC1lZIKJLuXMXwEWvSlIq
         9W8SKABTGR3oFlN/WYwZlCh3UHYZPfnsXv+YG37dn8z9a041Wy3ShsEzHpnv+8gpa/zj
         0EMUhPg+0hFD12SDwmKZT6AxhcxAyAxPC5VJzJT/+yPv9oLO/vQzseuN6yEYLQygsArO
         CC8dquhHmAYAXXeSfC1Dl+M/jMluzFpcK6Fucpo6dETm8dHjlABai0aBOA8NYpCizfUh
         wNA2uXPyJbPUN31ltTSCpJExsVXXmXzvYuaBG/gdVjAPUODReBKFX3ilTn+TT8P1Y7Gw
         w89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784036270; x=1784641070;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=emlgPvqXL1rZ/dk2g2h33xQdXZOEmYyk1lxLipg2WQk=;
        b=JMUDN7ZX2vonNWn0KZ9YzTVB4gkCgrFvnpBXNeVSzcn6ajS7r7sOKNVdAeUc1wzNlA
         MTBn1VaWefm4zUiODAkRi9mkgYIPbCTOJN9d/PfP7vbqZffTgcKZsyqZY96H7tUAbmxJ
         /tXlRHn5sqntJV4m6Iu/sRBz1R8tlym1uUj7sqC3y9oW5nnNsI2pdpAwfKiIOSgYjArT
         PPwRKA2MKcXjEQy2Hyb1RuzBpvHu2aQmDK3xaPtCj8rLDRXryQw3XcLT2Thz16bijoFT
         1YCgiWUCpnG/GofZDVpH7xm7gOxdhdwSFKRSkNZ22SdnPWyuH5tJi2WEoNTn9OLKT9/m
         Y8PQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJyEr7orSNoUxi6/9iYG8sZ4/4d8+FB4di7i+cIVofqYC1DrtkZsHCLyRAJLL+OgXZGXc=@lists.linux.dev
X-Gm-Message-State: AOJu0YysX//Ba60sX5rfRfXjwdpHitHUN35G3JKBt0pTpqrx8NJ3X8q1
	I0mWU/B6gymgGuTZcyxCsX4Olg9cPX2Xx1+EVqaFe9sNuXU109f/KvUJa7SuEg==
X-Gm-Gg: AfdE7cmjfra+UuaNsJDmltRP/9R0lFgf7uYY+0b+7PN2Up11KFd9YcProB9C55/LRzF
	NPR3B8QRk/5Ipmiva4fKc2INjc6636VxzoZKnr5Yhe2wb0c8L+40VwYbfk96aTlKpZdl+IzQKle
	GXP9g1GUS7OnR2dbDISMZFUrTx3cKV69JQ9QczuIL33ZYMs5PauTDF6BspBZXE3DzY9zZbnee0j
	dD4DGU2+Uur7+YUtmyTtf+t6HtAoqGUWkkXFId3KSOSROctUDSPZXecE672aQ+wHDEehfBzJdWR
	C2UJ84+dSL+ziP55PazDrydkqzIMjV4yNe1DAgM5D0i2vqytaC2NfCTZ0HCu9iwHu1XkPoPHWUD
	azz1p+z82bjiCEE6j8CiRY0kX+FHXQ6OVKvuKHVXfStjI6cE2Tg0vc1RC4olYHRCPhUR6SB4vEt
	88hL9vnyXvzWAIcBMISJMWX5/0jkNZnENlRd642SKHHmixnsSANo6rBrzpP+mCNPKXkuzbqsHBV
	4Mc5yUV/KuJh407gW/Z8mQ6C08=
X-Received: by 2002:a05:6a21:1798:b0:3c0:9c1a:8952 with SMTP id adf61e73a8af0-3c110b35019mr13832313637.74.1784036269953;
        Tue, 14 Jul 2026 06:37:49 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3a2e420sm10043006a12.29.2026.07.14.06.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 06:37:49 -0700 (PDT)
Message-ID: <086d4214-d1b0-4ef4-9cdb-6bc94d3ed07d@gmail.com>
Date: Tue, 14 Jul 2026 06:37:48 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] src/station.c: fix of SEGV in
 station_roam_scan_notify when performing repeated roam scan at legacy roaming
 after ft_auth-/ft_reassoc-timeout when using mwifiex / NXP 88W9098 driver
To: Dierk Modrow <dierk.modrow@sew-eurodrive.de>, iwd@lists.linux.dev
References: <20260713113506.1081-1-dierk.modrow@sew-eurodrive.de>
 <20260713113506.1081-2-dierk.modrow@sew-eurodrive.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20260713113506.1081-2-dierk.modrow@sew-eurodrive.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dierk,

On 7/13/26 4:35 AM, Dierk Modrow wrote:
> From: DEMODDIE <dierk.modrow@sew-eurodrive.de>
>
> ---
>   src/station.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/src/station.c b/src/station.c
> index 8fcf8c70..077e510e 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -2253,7 +2253,7 @@ static bool station_can_fast_transition(struct station *station,
>   {
>          uint16_t mdid;
>
> -       if (!hs->mde)
> +       if (!hs || !hs->mde)
>                  return false;
>
>          if (ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
> @@ -2917,7 +2917,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
>
>          orig_security = network_get_security(network);
>
> -       if (hs->mde)
> +       if (hs && hs->mde)
>                  ie_parse_mobility_domain_from_data(hs->mde, hs->mde[1] + 2,
>                                                          &mdid, NULL, NULL);
>
> @@ -2930,7 +2930,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
>          if (bss && !station->ap_directed_roaming) {
>                  double cur_bss_rank = bss->rank;
>
> -               if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
> +               if (hs && hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
>                          cur_bss_rank *= RANK_FT_FACTOR;
>
>                  cur_bss_group_rank = evaluate_bss_group_rank(bss->addr,
> @@ -2967,8 +2967,8 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
>                          goto next;
>
>                  /* Skip result if it is not part of the ESS */
> -               if (bss->ssid_len != hs->ssid_len ||
> -                               memcmp(bss->ssid, hs->ssid, hs->ssid_len))
> +               if (hs && (bss->ssid_len != hs->ssid_len ||
> +                               memcmp(bss->ssid, hs->ssid, hs->ssid_len)))
>                          goto next;
>
>                  if (scan_bss_get_security(bss, &security) < 0)
> @@ -2986,7 +2986,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
>
>                  rank = bss->rank;
>
> -               if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
> +               if (hs && hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
>                          rank *= RANK_FT_FACTOR;
>
>                  group_rank = evaluate_bss_group_rank(bss->addr, bss->frequency,
> --
> 2.53.0.windows.2
>
Are you sure you're not looking in the wrong place? You mention ft_auth 
and ft_associate, but the behavior differs significantly if there's a 
timeout:

- If ft_auth times out IWD will try another BSS and the handshake is 
preserved.
- If ft_reassoc times out the kernel forces a disconnect, destroying the 
handshake

That said I'm not sure how we can get into station_roam_scan_notify 
without a handshake... If we ever disconnect the scan callback should be 
canceled, even if its still in-flight ELL will null out the callback, we 
should just never get there.

Is there a bug causing the callback to get called? (maybe?) but if so 
that's where we should fix this, not checking if the handshake exists 
when it always should. An L_WARN_ON check might be appropriate at the 
top level to both prevent a hard crash and provide a warning that there 
is a bug.


Thanks,

James

