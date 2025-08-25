Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B001288C39
	for <iwd@lists.linux.dev>; Mon, 25 Aug 2025 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132650; cv=none; b=UfLdo5WJSa8dzg0JhGivbeun36p+EOSX8cOwXpAqbI76o9pyZtAxf5np4xS+QJFtYP7RilQeK262ttqJeE3tgXCXZZFVVuz6oezeFe2bGIJQxjlex7hzhCOV89Lv7W4m8yTcy2YZ22oOFiEEEWoE0kaEVSNRrsyMaTDgsFxcFh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132650; c=relaxed/simple;
	bh=yu2TDrSbvSCLI394HCbogl+x51pVzIonJzpe38i5eDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTwNeZBKgs5ifKtEdNhle7dQE30b7OZXjgtRmq312ExKLe0qbAe6w3SLfHboz5nswyrQW+3O5gGFndgShcAKykgS1xpn2uJKOHirXRno0oxtMty2KzL2fy89lcjLThXhQRvI9lqtHw/rM4lIfCvdsKhQJ9N2saA3XAWlY4QoPJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSxu1O7U; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSxu1O7U"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e8702fd3b2so433095285a.0
        for <iwd@lists.linux.dev>; Mon, 25 Aug 2025 07:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756132648; x=1756737448; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ASpuOHeBvR25dZwTE569/oHHjxfVJCxmlhyuR3dYFM=;
        b=KSxu1O7UYa6CdhWQRkBeCsNs5q1ID1shB+ksESGJ/G6lL/2K1F6gO8BdCVowtVxPA3
         jueSRSd072EGnkQZN+axIjWBrVKmBC5h9tDVigI0BPl5fLBDEBsp2vh99ROwjUUibm7y
         izS+YzRnehtMN6QyWBGwke75kAUyfI4QaeKdQ1L2s9Lz9A8wgn4CJrxcvo2wtTW1/drw
         7rJSr2ztqpFUEBBbYkJ9aNA3jW3DKhDmyLvzIeep83YKIugnqC53m61BIcJTkpifhvQF
         SkFFom8cUsJK+m+ZW/c4vZd/IHndNAp4zL79c+GWtH6KsJYIn5t3kW3qt7+PYsV/iyQG
         YmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756132648; x=1756737448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ASpuOHeBvR25dZwTE569/oHHjxfVJCxmlhyuR3dYFM=;
        b=U+hj81VMJQZkBxTviBGjiYioireysDpgODcGIpy24wl0nU0h0GYpc0wrCO1XrSnTxZ
         IKV8KxnbPiYRpnuSZg9Jw04BUyRkWtBKe6WiEljgJsMrJrJkbfy2lkGBlAB/URThAV2S
         BJD9GMvsoVrB6cMPMXGExtqBG3RQTJvlkZUIrgy0+ontsDvp6yymuYMPURSe+Ij3+PYl
         f9AQMq4ao7QufgXVeAG/Itje1Kp9So8dPZMdYOOM52v7VTDKI6yWZFk01HXDeBhkdz55
         RNpB+N4ihW3L8EKJ3fec8B1tqIwZNl0cmHw9Uf6Hhcs1rTLoZQfqT/4y4gWXEmdP59R0
         DUbw==
X-Gm-Message-State: AOJu0YwoM9K0Pv9LWTHvUXc/bTNyUjN2hNjc6B5/PtyCyxXZJJxGBcmd
	qYJCy9p0zIu8tt5/meaK/bs30x+7lEBXRn/loN3urV/dp29in2t2brht3T4qLA==
X-Gm-Gg: ASbGnctQlJ9rXEzKj+Zoz+LFAk/rhxQzCmmFmf4yaxKkPlWaLYeWHqO1KGkQ1yA9qPE
	2aOhrtKULhPIe1xSVfu2vXHrcBfv+1rJZpnJ0rFZxVJmjDDUi7qogZykWUL+dOz5bHUIHWtSfPG
	kyIP6L+FaQLscyjiPMq6mfHyFrXD/3rraK3sWVgieRiXDpDL6mqFTblplddv5h8WOEY9dbH2x5z
	3EJHuB1uoX70H1BXrGg+cwWnbXBwckSgM81SxkkO4ASpqA+vLscdRrZG5DI325UhwrxEcwBQiqd
	18CkJdZZssCUhX6YfVzW3HrUbIxjrZs64MzTUpSvk/696OnybRMFMEhigMTr5NSZUjIp2lWhn10
	nr/HTgVaXyJWKFiUC1yduPaabQw==
X-Google-Smtp-Source: AGHT+IHPKYQra3zVZWS8se0ja9ReM0aphyrB3bZakQ7E3AvUVgbnSBnCDUkGJbqycpqdM9tPh5y1zQ==
X-Received: by 2002:a05:620a:462b:b0:7ea:f50d:8e8b with SMTP id af79cd13be357-7eaf50d9607mr1230215685a.21.1756132647724;
        Mon, 25 Aug 2025 07:37:27 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ec2f1cfd61sm468193585a.38.2025.08.25.07.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 07:37:27 -0700 (PDT)
Message-ID: <3ec6ca5f-9f7a-4c79-afe9-5ac980c60cda@gmail.com>
Date: Mon, 25 Aug 2025 07:37:25 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] station: check vendor quirk for BSS TM request
 candidate list
To: Marcel Holtmann <marcel@holtmann.org>
Cc: iwd@lists.linux.dev
References: <20250822195118.271122-1-prestwoj@gmail.com>
 <20250822195118.271122-13-prestwoj@gmail.com>
 <326D0476-1D08-4666-B820-EBAB74265608@holtmann.org>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <326D0476-1D08-4666-B820-EBAB74265608@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

On 8/23/25 7:48 AM, Marcel Holtmann wrote:
> Hi James,
>
>> If the AP vendor has known issues with the preferred candidate list
>> ignore it and jump directly to requesting a neighbor report.
>> ---
>> src/station.c | 5 ++++-
>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/station.c b/src/station.c
>> index 4919f89e..3424964d 100644
>> --- a/src/station.c
>> +++ b/src/station.c
>> @@ -64,6 +64,7 @@
>> #include "src/eap-tls-common.h"
>> #include "src/storage.h"
>> #include "src/pmksa.h"
>> +#include "src/vendor_quirks.h"
>>
>> #define STATION_RECENT_NETWORK_LIMIT 5
>> #define STATION_RECENT_FREQS_LIMIT 5
>> @@ -3378,7 +3379,9 @@ static void station_ap_directed_roam(struct station *station,
>> l_timeout_remove(station->roam_trigger_timeout);
>> station->roam_trigger_timeout = NULL;
>>
>> - if (req_mode & WNM_REQUEST_MODE_PREFERRED_CANDIDATE_LIST) {
>> + if ((req_mode & WNM_REQUEST_MODE_PREFERRED_CANDIDATE_LIST) &&
>> + !(station->connected_bss->vendor_quirks &
>> + VENDOR_QUIRK_BAD_BSS_TM_CANDIDATE_LIST)) {
> this is unreadable in the long term. I would either add a variable or add a helper for the quirks.

Agreed. I think a variable makes the most sense. I contemplated 
something like:

vendor_quirk_is_set()

But you'd need to pass in the mask/enum which probably ends up eating up 
more characters anyways. Instead I can just do a local variable:

bool ignore_candidates = station->connected_bss->vendor_quirks & 
VENDOR_QUIRK_BAD_BSS_TM_CANDIDATE_LIST;

>
> As a side note, you might want to actually somewhere print the quirks which are active. Otherwise your debugging in the future will become a nightmare.

Good idea, I could probably do this upon connecting and when roams 
finish. Its probably a bit too verbose for scan results.

Thanks,

James

>
> Regards
>
> Marcel
>
