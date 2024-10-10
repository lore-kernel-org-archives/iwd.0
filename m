Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5311CDA11
	for <iwd@lists.linux.dev>; Thu, 10 Oct 2024 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570217; cv=none; b=HRjzG+FYv53jF1bCa/hSkqPX4O/Mi+vzdYtbtxWMf17iMAzDbWjCCg840IgPdfOEXLi1K577Wa4Ojtg0iu8zZ7ywDrF8eeGpyoSKl2ZJgzGraQbGePeLPvR4RqWpqnjQmzaHBFnXFIPU0YiEhWozXrVGCWgf0i+LQU2lbNjQInI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570217; c=relaxed/simple;
	bh=lJUmw5Dvat6vVzsZ+gmqINdcwElkIJA5OaQa7wRODCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dMTGQSZIubgYzJnJsIs/gRVdha3uwnmWDzLUuWtk2zCeLNQi5qtksQpTigr9oFC9hPa3kIMn2uKsKXZAyhK3Z/BdPW50KNQ2wj7MAcoZmpx1TqZ5voK1PK0Bl2RXO3PYAZbnb0SUmtq0H6c9n0v9CKBWR6yDMBtLbk5IIeKh4vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iu83SOHT; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iu83SOHT"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-45812fdcd0aso19630781cf.0
        for <iwd@lists.linux.dev>; Thu, 10 Oct 2024 07:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728570213; x=1729175013; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h1kiH2fuMDOn+vxg916loQq5msghU5JH1gdWiFg8h4k=;
        b=Iu83SOHTTyR+lYgaIiSOP2HMxc8X2AzpfM90Ki48EAF3Z/JvOMS5dVuw8Qw5NTd2yn
         OQQv4UzKhuMnpFs1fhD23V1XOdYyFQvARV7cNym2pq2T2iUqU4lUjjdDof7kXW6Rp4qJ
         0iVBKr4hdJYWiBpaJPyrQ3hPuVf3U7iUjYU3w78tKoJjJLx45O+8yBor00Y7RXLByKtA
         EeE7ibceqv93HHMe5GSt7kD6hD54kUaT47s7Yy4nnCUocjBl4ZXoCOI1p0vRxj9x2BBz
         /xFnuRtWWlSEAk59KgjdsSu6z9+LvwWG1CV4I6kX85QmlQ/yzhg19fS2LQbp9Xv3Q4i5
         PNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728570213; x=1729175013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1kiH2fuMDOn+vxg916loQq5msghU5JH1gdWiFg8h4k=;
        b=YxMzkrFyvUzhz0Ie54Ky6Hy6H4SBqISpPRP5w8ZaA9TLDdAFHdsg9lP/AtI/aLLSmP
         3c8H0bxCOg8PBuxZlGYIeK0KxBTwry+8oLyDlT7NaxYrFHGlh+f4f9APsK/B49gORFbu
         P9GqMXLgV0FFKbUUj9TkP6j8TgA76iqoeW8rjcSF3vFNOmUmUJBNBSCodDKcrGGzm3XC
         Ay1FUbbbGFPYWrQDfDvubBVIG8bW3gIg/lOzaG2jdWC1bjUoBkofhihebcb3cMx4xI1e
         z69SfHgwetcwJVU0XGdfplXIfA4J5IlaRYGB7DNzJQeroATYJbLj11gskI5IZMTuEJ8x
         aXKg==
X-Forwarded-Encrypted: i=1; AJvYcCWnC+u0PNLAG0XMs3YEN9Or4vA2hYlgWxsvZWa01dSdplic7WiGIAUfpR8sbLy5IzghRqE=@lists.linux.dev
X-Gm-Message-State: AOJu0YywLngdvv9y3XVj+Tcaia47XYbhVM4WAJW2sBWdVmGEF3fZnrr+
	1cDWNATjj0E8/J+KuguDP82Gs2ScZBGUmfhwhrU2BX/Py22DNucCRfTA+g==
X-Google-Smtp-Source: AGHT+IF5sQDY5h+nMg5vSFjrBFYLixHM+cpEweZ1A9Hj35A5S/lqDgYPdUCICYz29Lrv5b8KEbu4tw==
X-Received: by 2002:a05:622a:4896:b0:45f:677:d395 with SMTP id d75a77b69052e-4603f5f1fbfmr62275211cf.17.1728570213005;
        Thu, 10 Oct 2024 07:23:33 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460428079bbsm5785691cf.50.2024.10.10.07.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 07:23:32 -0700 (PDT)
Message-ID: <c477b2d9-dcc7-4ea7-a6b1-47f6f84e4736@gmail.com>
Date: Thu, 10 Oct 2024 07:23:30 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AW: IWD 2.20 does not support Fast Roaming with NXP 88W9098
 chipset
To: Dierk.Modrow@sew-eurodrive.de, iwd@lists.linux.dev
References: <5c65040719764a49a48846ea11c535a7@sew-eurodrive.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <5c65040719764a49a48846ea11c535a7@sew-eurodrive.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dierk,

On 10/10/24 6:49 AM, Dierk.Modrow@sew-eurodrive.de wrote:
> Hello James,
>
> we tried to implement 802.11r roaming with IWD 2.20 using a NXP 88W9098 chipset from H&D Wireless as client (using out of kernel tree driver of NXP moal/mlan -> FULLMAC) and failed.
Are you sure its a fullmac card?
>
> First problem seems to be an error 'iwd[28112]: Could not register frame watch type 00b0: -22'
> It's the call netdev[5540]:       frame_watch_add(wdev, 0, 0x00b0, auth_ft_response_prefix,
>                                                  sizeof(auth_ft_response_prefix),
>                                                  netdev_ft_auth_response_frame_event, netdev, NULL);
>
> I traced it through kernel /net/wireless to cfg802_11 and the NXP driver and found a problem in the driver capabilities setting so that NL8011CMD_REGISTER request was already denied in the kernel.
> (see analysis_register_frame_type.txt). Having applied the patch zz_ft_auth_register_bug.patch to the driver the error above has gone.
>
> PROBLEM
>
> The first association with the FT-enabled AP is ok, but when the first FT-authentication occurs, it fails with
>
> Sep 26 13:00:34 sew-mnc-51321 iwd[28112]: ../iwd/src/ft.c:ft_send_authenticate()
> Sep 26 13:00:34 sew-mnc-51321 iwd[28112]: ../iwd/src/netdev.c:netdev_ft_frame_cb() Failed to send FT-Frame
>
> In IWMON-log the NL8011CMD_FRAME with the FT authentication.req fails with EINVAL:
>
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]: < Request: Frame (0x3b) len 200 [ack]                                 30.060808
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:     Interface Index: 9 (0x00000009)
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:     Wiphy Frequency: 5240 (0x00001478)
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:     Frame: len 173
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         Frame Type: 0x00b0
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:             Type: Management (0)
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:             Authentication:
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:                 Frame Control: protocol: 00 type: 00 subtype: 11 to: 00 from: 00 more_frags: 00
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:                     retry: 00 power_mgmt: 00 more_data: 00 protected: 00 order: 00
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:                 Duration: 0
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:                 Address 1 (RA): 38:4B:24:96:05:38
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:                 Address 2 (TA): 78:C4:0E:E0:18:60
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:                 Address 3: 38:4B:24:96:05:38
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:                 Fragment Number: 0
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:                 Sequence Number: 0
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:                 Algorithm: FT (seq: 1, status: 0)
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         b0 00 00 00 38 4b 24 96 05 38 78 c4 0e e0 18 60  ....8K$..8x....`
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         38 4b 24 96 05 38 00 00 02 00 01 00 00 00 30 26  8K$..8........0&
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         01 00 00 0f ac 04 01 00 00 0f ac 04 01 00 00 0f  ................
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         ac 04 00 00 01 00 18 8c 0a 27 37 f5 7d a2 6d 33  .........'7.}.m3
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         53 fc 7b 8e 83 e1 36 03 00 01 00 37 60 00 00 00  S.{...6....7`...
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 24  ...............$
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         ca bc 3e 62 db c6 0f c5 23 8a 7d f9 cf 68 d3 fb  ..>b....#.}..h..
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         08 14 16 34 4c 12 86 66 b0 c4 82 fe 54 fb e7 03  ...4L..f....T...
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:         0c 33 38 34 62 32 34 39 36 30 35 32 30           .384b24960520
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:     Offchannel TX OK: true
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]: > Response: Frame (0x3b) len 4                                        30.060851
> Sep 26 13:00:34 sew-mnc-51321 iwmon[28111]:     Status: Invalid argument (22)
>
> A concurrent setup with wpa_supplicant V2.10 does work, but a look on IWMON yielded, that wpa_supplicant uses NL8011CMD_AUTHENTICATE with different NL80211 attributes whilst iwd uses NL8011CMD_FRAME with the full 802.11 ft_authenticate_frame as value of ATTR_FRAME.
Generally fullmac cards don't let you use CMD_AUTHENTICATE, but the only 
card I have experience with is brcmfmac. IWD doesn't use 
CMD_AUTHENTICATE because its intolerant of failures, if the AP 
ignores/rejects the FT attempt you have to fully disconnect. IWD instead 
uses CMD_FRAME which can fail and we can proceed to another BSS. 
Apparently though your driver doesn't support CMD_FRAME nor registration 
for auth frames.
>
> Does wpa_supplicant use another NL8011 API for FT-Authenticate / FT-Associate than iwd?
>
> Another short try with a QCA chipset using ath11k (SOFTMAC) seems to be working with IWD 2.20 and FT-transition ...
>
> I have attached different IWMON logs as PCAP files:
> nl80211#wpa-supplicant-good.pcap              Good: FT-transition with wpa_supplicant V2.10  -> Frame 200: ft_authenticate, Frame: 201: Response to ft_authenticate, Frame 204: ft_associate, Frame 208: Response to ft_associate
>
> nl80211#iwd_register_fail_ft_fail.pcap          Bad: frame registration in iwd 2.20 fails, FT-transition fails -> Frame 90: register_frame type auth, Frame 91: Response to register (EINVAL), Frame 294: ft_authenticate, Frame: 295: Response to ft_authenticate (EINVAL)
>
> nl80211#iwd_register_ok_ft_fail.pcap           Bad: frame registration in iwd 2.20 succeeds, FT-transition fails -> Frame 158: register_frame type auth, Frame 159: Response to register (SUCCESS), Frame 531: ft_authenticate, Frame 532: Response to ft_authenticate (EINVAL)
>
> I also added a sorted log file containing iwd traces, iwmon text logs and kernel msgs (of the NXP driver): resorted_logs_of_iwd_ft_connection_trial#3.txt
>
>
> We would like to use iwd instead of wpa_supplicant so any help would be appreciated!
At this point in time looking at the above logs it appears IWD isn't 
compatible with this out of tree driver due to the requirement to use 
CMD_AUTHENTICATE. I've thought about adding this back in for "weird" 
drivers that have problems with how IWD works. For the near term we 
could try and detect this case, via the CMD_REGISTER failure, and 
disable FT entirely for drivers like this. You'd be stuck with only 
reassociation but at least the device could roam. I can get you a patch 
to try soon.
>
> With best regards
> Dipl.-Ing. Dierk Modrow
> Development Engineer
> Development Electronics -
> Industrial Controller & Communication 2 (DE-ICC2)
>
> SEW-EURODRIVE GmbH & Co KG
> Ernst-Blickle-Str. 42
> 76646 Bruchsal
>
> T +49 7251 75-5123
> F +49 7251 75-505123
> mailto:dierk.modrow@sew-eurodrive.de
>
> https://www.sew-eurodrive.de
>
>
> ________________________________
>
>
> SEW-EURODRIVE GmbH & Co KG
> Kommanditgesellschaft, Sitz: Bruchsal, RG Mannheim HRA 230970
> Komplementärin: SEW-EURODRIVE Verwaltungs-GmbH, Sitz: Bruchsal, RG Mannheim HRB 230207
>
> Geschäftsführender Gesellschafter: Jürgen Blickle
> Geschäftsführung: Jürgen Blickle (Vorsitzender), Dr. Jörg Hermes, Dr. Hans Krattenmacher, Christian Mayer, Johann Soder
