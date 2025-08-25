Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3B82FC01E
	for <iwd@lists.linux.dev>; Mon, 25 Aug 2025 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132310; cv=none; b=eNn8Ic8gW54n1tNWT7ttOPmS1FgmmDBXf/hi49dAp47D3XXv+3LQ1Bx4DWYcN/Amguc0MovC+FJcnIv4d7zZOEOevD/O025MjKu/3GIFNBm/ksS6Wv1/h7mfE3A4IU4Rc+pMwfnWPdRQwA7n9nizpmWpG7y6lsJGCok5FAGeMUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132310; c=relaxed/simple;
	bh=4xIy3z4IIjX8IJ8E5DsU1Td7S6pIjsvNMGNRGkO4llc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBO2o9jSXluGuYjE7oM8IKUCBeA/X0EK7fcIl90xxcSw4V7mAaXVBzzDQluNx47A0I/hHB33fhgusNgn6nrmeuZdrzlBJHiu0kQIQH2/zt/TNLYdYVLp/nK+BWeTL23zYh9dBWt9rdyVu3YgutJfu4v9dKYdIRoKZCBTZysKiBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cagrlbty; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cagrlbty"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70da75014b6so21445006d6.1
        for <iwd@lists.linux.dev>; Mon, 25 Aug 2025 07:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756132308; x=1756737108; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+zHXBju+S0uOfF+Cu9Y1hgimkIMx6uzQelOqSfGEMgA=;
        b=cagrlbtyTyqjKTjGYLIprA3YKBfEd74EzLiu83TSbEpWabtx9DxRx3wpUcOTSP/rTt
         /207W9BYOafjGHvyq1Ilho5l2lfcPjcbv7yHuG1d8hg+BRTsW0UFf9mCml83EatBS31m
         OQSdJCTAuI9LxS5+p9b+AqnDDsTh/byDJb7ggMLPcI2qN3HhFwndzUFcUKgRtWQ0mBeu
         H28HXxgb892ddzdrPTTaT13n0/xrrygcJTkC8EqXNUH//e+sphtmZTDAokw6u0ZSfVpY
         xT9X5jIxLIFD3tODBTu+5t0wYszTlDnFrvcvBhzacaUjftyUPF2IzEr+8p+AfBzEeGt0
         DG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756132308; x=1756737108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zHXBju+S0uOfF+Cu9Y1hgimkIMx6uzQelOqSfGEMgA=;
        b=WwrJdhdxoCV5awZ45t1o40MMCCdUMupjqNH+QQBDe+Ma0JQp773L6H9McP6sDeCsq2
         hN3qL9POztYCNhgNaIOoYbF0CbWXzuBv9JvfjLX5tAmvGjznvoTrmGrzM84ZfclDnN+D
         dwfLaDPDeVr6rOWhh0UNWuHDfNCpI+CRCGGWuvmE8LxuVvWVBuZtGw+KN2bk4EWalJIg
         ixamCc2saHGqqtsRTm32SbbvWAZar2YRLlAQXDp1GV8t8JqMNCHVD8RTjW/pYYHaz+l4
         HbOlclI/n5NvLmel+dYmDUiqGzbZspbOxt7vOex6lvCn6JINjDym5VlVNRVLOaKSzwf5
         PoPQ==
X-Gm-Message-State: AOJu0YxkmxfQ4B5N93j7qrUN7bELcnzzFuOjMP39eNAAAUl1CqyufLQt
	0t564WgBRn4GLNrJwJoM270UY8bMm7H0Yu0hl1RTcLmUTQxuv2uMcfCXaGIOyA==
X-Gm-Gg: ASbGnctAWf9kXCCYQ7CCW+jM4/9cK/m5BqXxr2pVxZUxD5AoFce/OyrbbnsawkYQVU6
	85zuwKFYqzL7kGWrkVdWri0ci19d122zDRsPxzGhgfYISRfzrd9UMc19N1YbvgnHMsYHD660Kyg
	ul3utD5ItmjCVWNA9P65d+hAqabOC0LC7QKXamr1HyyaHf0LzjJwUXKxMa2SwAUs5JE1+PRjWfW
	ITpOWY9kLCvb0yd0StGqlP2GDkYIEo/mG5iEWB8Uqi45Zx6c12JWAM4F52og8zU+a/NBrgf/jeF
	eZs4ytsWCnAkhCnrtY16RtRqU6GZc9eXYDo9Q2LLNfl58aEklg7KAt+/AUXEfgbOlzs3GTy8djA
	OHiYrlpM51aUONyCJCFQagWUIiA==
X-Google-Smtp-Source: AGHT+IHplOrvTEfpJg6TqMLGWkN2cR8P7T+3A60BBmnEerih07QR0hfez5b/G1VeAniiB3eUPOC++w==
X-Received: by 2002:a05:6214:4110:b0:70d:a88f:1915 with SMTP id 6a1803df08f44-70db9b35a40mr55390716d6.55.1756132307476;
        Mon, 25 Aug 2025 07:31:47 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da717df65sm46285496d6.30.2025.08.25.07.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 07:31:46 -0700 (PDT)
Message-ID: <ab7f5b0d-5224-43a3-8836-8bc3aea96c5a@gmail.com>
Date: Mon, 25 Aug 2025 07:31:44 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/15] vendor_quirks: initial skeleton
To: Marcel Holtmann <marcel@holtmann.org>
Cc: iwd@lists.linux.dev
References: <20250822195118.271122-1-prestwoj@gmail.com>
 <20250822195118.271122-5-prestwoj@gmail.com>
 <DED368F0-5FD4-4360-9C55-37D405566887@holtmann.org>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <DED368F0-5FD4-4360-9C55-37D405566887@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

On 8/23/25 7:43 AM, Marcel Holtmann wrote:
> Hi James,
>
>> This module will provide a database for known issues or quirks with
>> wireless vendors. For now the list of quirks is limited to 32 as
>> that is the size returned in the bit mask. This could be extended
>> to 64 in the future if needed, but of course the goal is to never
>> reach that level.
>>
>> The vendor_quirks() API is intended to be called from scan.c when
>> parsing vendor attributes. This will lookup any quirks associated
>> with the OUI provided and a mask of quirks will be returned. This
>> can be repeated against all the vendor OUI's seen in the scan. The
>> result is then a bitmask containing all quirks for that BSS. This
>> can then be referenced later during various operations in IWD.
>> ---
>> Makefile.am         |  2 ++
>> src/vendor_quirks.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
>> src/vendor_quirks.h | 25 +++++++++++++++++++++
>> 3 files changed, 80 insertions(+)
>> create mode 100644 src/vendor_quirks.c
>> create mode 100644 src/vendor_quirks.h
>>
>> diff --git a/Makefile.am b/Makefile.am
>> index 92adfa6e..c01cd4c4 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -274,6 +274,8 @@ src_iwd_SOURCES = src/main.c linux/nl80211.h src/iwd.h \
>> src/dpp.c \
>> src/udev.c \
>> src/pmksa.h src/pmksa.c \
>> + src/vendor_quirks.h \
>> + src/vendor_quirks.c \
>> $(eap_sources) \
>> $(builtin_sources)
>>
>> diff --git a/src/vendor_quirks.c b/src/vendor_quirks.c
>> new file mode 100644
>> index 00000000..ccfcb444
>> --- /dev/null
>> +++ b/src/vendor_quirks.c
>> @@ -0,0 +1,53 @@
>> +/*
>> + *
>> + *  Wireless daemon for Linux
>> + *
>> + *  Copyright (C) 2025  Locus Robotics Corporation. All rights reserved.
>> + *
>> + *  This library is free software; you can redistribute it and/or
>> + *  modify it under the terms of the GNU Lesser General Public
>> + *  License as published by the Free Software Foundation; either
>> + *  version 2.1 of the License, or (at your option) any later version.
>> + *
>> + *  This library is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + *  Lesser General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU Lesser General Public
>> + *  License along with this library; if not, write to the Free Software
>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> + *
>> + */
>> +
>> +#ifdef HAVE_CONFIG_H
>> +#include <config.h>
>> +#endif
>> +
>> +#include <string.h>
>> +
>> +#include <ell/ell.h>
>> +
>> +#include "src/vendor_quirks.h"
>> +
>> +static const struct {
>> + uint8_t oui[3];
>> + uint32_t quirks;
>> +} quirk_db[] = {
>> + { }
>> +};
>> +
>> +uint32_t vendor_quirks(const uint8_t *oui)
>> +{
>> + size_t i;
>> + uint32_t ret = 0;
>> +
>> + for (i = 0; i < L_ARRAY_SIZE(quirk_db); i++) {
>> + if (memcmp(quirk_db[i].oui, oui, 3))
>> + continue;
>> +
>> + ret |= quirk_db[i].quirks;
>> + }
> if you are using an empty {} entry to signal end of the array, then it makes no sense to also use L_ARRAY_SIZE.

I'm not, it was just to get the skeleton module to compile. The compiler 
wasn't letting me define an empty static array like that. In subsequent 
patches that empty entry gets replaced with real data.

Thanks,

James

>
> Regards
>
> Marcel
>
