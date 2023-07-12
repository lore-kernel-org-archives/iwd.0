Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CED1F199
	for <iwd@lists.linux.dev>; Wed, 12 Jul 2023 14:52:44 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-76772fde287so702557085a.2
        for <iwd@lists.linux.dev>; Wed, 12 Jul 2023 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689173563; x=1691765563;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FlIC3vhClJh+yJk9gogG8c/GOXraWdm/Rj0a9tKyIfo=;
        b=RoLbrvE4JzCDV3VKlNjAla1lQWdjH7PELiKzQ2zOjM5u5a44/vQazPJ+jXlmHnkQNs
         +LgaaRCQ+grKPHuX+s/0WAjOx2dBSpasl6MhfFJ7TBYQuxezrJJeyuVYuD+iBKx1ApdO
         hM0Veldu64hGkpWS1dH5wJqNK8Hlg6RYa0uNRZ/nW09zGyUTzm2CpijRTAjc0VHAbpIj
         8iKTCStIAUj30+ezxHk+5vmxhAbZm9Y1enrP+owCwzwQGCHnUdGDGZXnxWxZSNVBp8H7
         NBOF5OwTrfmZ8soFWU1xFp80FwcuHxxJS10p1tfW9T3HEVGJN53iCzz3cUBreWD1/c63
         Y2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689173563; x=1691765563;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlIC3vhClJh+yJk9gogG8c/GOXraWdm/Rj0a9tKyIfo=;
        b=gECgP+XluHEMqlxbHolovhWfYVMRdlVBHqHBv0HUWBhixUXXIR2JiVRCTim7ZVB1GK
         +rMNp1yzwPUZl01AP72mdAztKkjxuMNmd0kiLm/5pJkhq4/oD6h6RM3zhxBEp4choz4y
         k1J2/z8tz4crW0hwNV34HYaCnP99r74gm+5xnuqNY3ViLAofoOXX3fMXWs+59M3CDCXm
         5hPJ0knjvYjO4Q3igYXHsxGI1u3QJFjG2QoE1x1CLW/9RSDHaIp5ECi/4+XnFKlBB8Tr
         K7kWKyMWJCyj3brrnMp+EhFweVGf9F3RtMonD165an8aVcyaS83/nYrKOkoI5iwcCZf7
         mkhw==
X-Gm-Message-State: ABy/qLalIVC7D46PD4nsCJXKGCEMT1eEWRl/SbX4NVX9zYoaUcd1Td6w
	DyO2SympfYjiQqYB/MXiw8tMu4S6ELM=
X-Google-Smtp-Source: APBJJlHcWM6w1dEEwSjOL+oFjpiSaF6zw3/nStgC0z+NYDnWqqMOd9LoXh+OBcM7+uLUUQ/rDGG0SQ==
X-Received: by 2002:a05:620a:2a07:b0:763:d32b:507f with SMTP id o7-20020a05620a2a0700b00763d32b507fmr25604896qkp.48.1689173563024;
        Wed, 12 Jul 2023 07:52:43 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c12-20020a05620a164c00b00767dafbf282sm2194583qko.12.2023.07.12.07.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 07:52:42 -0700 (PDT)
Message-ID: <411c867b-f830-c66c-4c21-f59200993b2a@gmail.com>
Date: Wed, 12 Jul 2023 07:52:40 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/3] owe: netdev: refactor to remove OWE as an
 auth-proto
Content-Language: en-US
To: Wen Gong <quic_wgong@quicinc.com>, iwd@lists.01.org, iwd@lists.linux.dev
References: <20210903193544.13897-3-prestwoj@gmail.com>
 <a7e76f73-da60-57fd-6686-b26e5c342d87@quicinc.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <a7e76f73-da60-57fd-6686-b26e5c342d87@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Wen,

On 7/12/23 4:17 AM, Wen Gong wrote:
> On 9/4/2021 3:35 AM, James Prestwood wrote:
>> ---
> ...
>> +
>> +            case IE_TYPE_RSN:
>> +                if (!netdev->owe_sm)
>> +                    continue;
>> +
>> +                if (ie_parse_rsne(&iter, &info) < 0) {
>> +                    l_error("could not parse RSN IE");
>> +                    goto error;
>> +                }
>> +
>> +                /*
>> +                 * RFC 8110 Section 4.2
>> +                 * An AP agreeing to do OWE MUST include the OWE AKM in
>> +                 * the RSN element portion of the 802.11 association
>> +                 * response.
>> +                 */
> Now it is happen connect to OWE AP fail with some APs, because the assoc 
> resp do not inclued RSNE.
>> +                if (info.akm_suites != IE_RSN_AKM_SUITE_OWE) {
>> +                    l_error("OWE AKM not included");
>> +                    goto deauth;
>> +                }
>> +
>> +                owe_akm_found = true;
>> +
>> +                break;
>> +            }
>> +        }
>> +
>> +        if (netdev->owe_sm) {
>> +            if (!owe_dh || !owe_akm_found) {
>> +                l_error("OWE DH element/RSN not found");
> 
> It failed here.
> 
> So is the check for owe_akm_found MUST added here if owe_dh is existed 
> in assoc resp?

As the comment states, the OWE RFC says that the RSN element must be 
included in the associate response if we are to stay compliant with the 
spec.

But as you may have noticed we don't actually do anything with this 
element besides parse it. I don't see that wpa_supplicant enforces this 
either, so it may be fine to relax this check.

I would prefer to see iwmon logs when you connect to this AP, just to 
confirm that the AP isn't including the IE and not something else. Would 
you be able to get those?

https://iwd.wiki.kernel.org/debugging

Thanks,
James

> 
>> +                goto error;
>>               }
> ...
