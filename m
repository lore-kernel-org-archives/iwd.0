Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565F07477
	for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 14:54:08 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-762092e1fb7so291730385a.1
        for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 07:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687186447; x=1689778447;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d4rf2zcyRgV1rCwkRBE1EAmZWDcYW6hN7Qy6njnuwH8=;
        b=nSycCBo2UWIOwP6PvFwLOlSaeOK4H5dSUv2g+4KF+ecp5bvqZBgQ9K2DeGv1USJT+b
         mNDI0hS2KwVy5qycypfIVKiri+i5lyNdly+7q24fY/KdAsX2EF4QEVMtpSUjknWaUgWJ
         thzkQ+PiNDT5FqB5Gsl580zib9JZ7UD4MGr1Qi8z6WiE75p6r8fv3/9qkeqO3ACICFqi
         ORsmqiR06WAk8nyvN84LGvKaggBIe+00TB83/cDeSYDKr17CGCpNT7/Mm66l3bzYxr7x
         S/8T0039L544LfsEkJVLjgmY79ON7VXCHfOEuyFeAebXYyk7AiGa54gcnEE+Yky9rZsc
         9SzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687186447; x=1689778447;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d4rf2zcyRgV1rCwkRBE1EAmZWDcYW6hN7Qy6njnuwH8=;
        b=BA3sUFtnqAeCjg8sFktqe739R7hun0Rs6bpNTK7NaZFwhHIhgL9Jt0lZq9NNcula0Q
         2JHJ1OB6Vmcef7Nmlx3QjpnLdv55nPA7OF7PWTsSME2L80nIMFypEb/hcyGml5Q0YamZ
         j0qtRrdh70Nii10kBHMx+AfYXLh7QDWnQp/c42rHdWaXeKYJA2Y6U+PDhA1Kn5xNcuL3
         LWRDpVEZrYCTo4YrFKjgRTVNu8TUnU+l0prHsvoC5v+MtqBoYZPUJwTkRDpVbP0/0/fY
         1EG5VNtF2i4Yelfy3+sseW5T/HEnjQSzzERmHtwfLPqhfP+kJHJUGZt+f89okPvFJSqD
         vivg==
X-Gm-Message-State: AC+VfDyOEBwI7fVLGxXQ0VIk2hH1NUBVM9mN5cn57/nrfYSohxduKciv
	bNP+OpmmZsdkIbBmhYd/G8v8wAKFHBw=
X-Google-Smtp-Source: ACHHUZ46+cXtPk83Ek9HmkbWB5Km75EfsFgppqLyn7G1usgwyHPWhddtm8Pw/wqsSFVTET8KaF05/w==
X-Received: by 2002:a05:620a:4248:b0:75e:b8b2:864d with SMTP id w8-20020a05620a424800b0075eb8b2864dmr9867120qko.69.1687186447099;
        Mon, 19 Jun 2023 07:54:07 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id oo24-20020a05620a531800b0075d4d5617cdsm15506qkn.66.2023.06.19.07.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 07:54:06 -0700 (PDT)
Message-ID: <c4e78f5a-e11a-bc90-bcab-688c79f5bf23@gmail.com>
Date: Mon, 19 Jun 2023 07:54:03 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 5/7] netdev: disable power save if required
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230615192415.1718516-1-prestwoj@gmail.com>
 <20230615192415.1718516-5-prestwoj@gmail.com>
 <8e99b15b-7730-3c25-7811-e1cef6f2d6e4@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <8e99b15b-7730-3c25-7811-e1cef6f2d6e4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 6/18/23 12:11 PM, Denis Kenzior wrote:
> Hi James,
> 
> On 6/15/23 14:24, James Prestwood wrote:
>> Disable power save if the wiphy indicates its needed. Do this
>> before issuing GET_LINK so the netdev doesn't signal its up until
>> power save is disabled.
>> ---
>>   src/netdev.c | 80 +++++++++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 66 insertions(+), 14 deletions(-)
>>
> 
> <snip>
> 
>> +static void netdev_disable_ps_cb(struct l_genl_msg *msg, void 
>> *user_data)
>> +{
>> +    int err = l_genl_msg_get_error(msg);
>> +    uint32_t ifindex = L_PTR_TO_UINT(user_data);
>> +
>> +    /* Can't do anything about it but inform the user */
>> +    if (err < 0) {
>> +        l_error("Failed to disable power save for ifindex %u (%s: %d)",
>> +                ifindex, strerror(-err), err);
>> +        return;
>> +    }
>> +
>> +    l_debug("Disabled power save for ifindex %u", ifindex);
>> +}
>> +
>> +static void netdev_disable_ps_destroy(void *user_data)
>> +{
>> +    uint32_t ifindex = L_PTR_TO_UINT(user_data);
>> +
>> +    netdev_get_link(ifindex);
> 
> So why do we do this in the destroy callback?  What happens if this 
> operation is canceled (maybe by hot-unplug?)
> 
>> +}
>> +
> 
> <snip>
> 
>> -    l_free(rtmmsg);
>> +    if (wiphy_disable_power_save(wiphy)) {
>> +        /* Wait to issue GET_LINK until PS is disabled */
>> +        if (netdev_disable_power_save(ifindex))
> 
> Should we be saving a command id here so we can cancel this operation in 
> case of hot-unplug?

Yeah I can do this. My theory for not was if it was a hot-unplug the 
cb/destroy were never accessing netdev directly, just the ifindex. But 
an explicit cancel (for getlink too) is better.

> 
> Ideally we should switch to using l_genl_family_new per netdev so that 
> all the outstanding commands are auto-canceled, but this might require 
> some care.

That would actually be pretty nice, and remove that massive block of 
cancels.

> 
>> +            return netdev;
>> +    }
>> -    netdev_setup_interface(netdev);
>> +    netdev_get_link(ifindex);
> 
> We should be saving the command id here too, but as a separate fix.
> 
>>       return netdev;
>>   }
> 
> Regards,
> -Denis
