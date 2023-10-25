Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27222D61E
	for <iwd@lists.linux.dev>; Wed, 25 Oct 2023 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcjeljKE"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-66d1a05b816so39597346d6.1
        for <iwd@lists.linux.dev>; Wed, 25 Oct 2023 05:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698237562; x=1698842362; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h9QDoXErk3/Hg4lk67CDxAS2ceuohCWwuBmPmAboLcE=;
        b=ZcjeljKEvBmPzTS3kkGiXmG74dWP+YnQ3jtMJDSOxmHQ9+gHCK08EoDiyQ91kKYzqf
         jHoR9iT1D2M2D4yp1dxzKGA5N5tKR8ynMC5p5y9CnSNcAwuba08wZ0DLp6nsQ3nrADmI
         Sa2lkvEepPeETN2zs1DQ+U3EbFPtj9iU6AC28HgfuN9/vmiBGP5BuM436A9c0JaK3TSG
         A6k1ZSWCHj64uzt3wkao7KWDNm3cMbd17Rvry3ikOM4Z+Ap5ba5yNLizqtxX96sNGRSI
         3Jvg6vYrXIz1cRiasduRnG0h1hT2P5kZJVqKu8akYC2cbMnX1c4ZnfVVTaUh2FSvtnV1
         OWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698237562; x=1698842362;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9QDoXErk3/Hg4lk67CDxAS2ceuohCWwuBmPmAboLcE=;
        b=UB3TmV6OtwdcM6lobF+c3nn/0xuoC5kbDdhi9jWbxLUTo3iASmpb0A4V05XBplKGg6
         QoT5mAop7X5n6yUG+/7kDZPKYxIXWJ1eAxMg2gG6nreRKtYAhcedricUTAzmKCtzRKGC
         4RXye0ml7i3jtsXYnFcTqckXyoOtbh9MmpJDO0BLbM92YlpcIpGSrTYxYjZQ8Rby2lz9
         HID22NtZclaI2vDbWdLVczJWhh00aZay9Kj4BC3fhro56xjWM9wlbO4U8qexME+IKAVC
         Rwj+D1YXKA89j9bH4brNE9f4zbrXDh4zJFvW4Oqln1n2t7iBxeb2Z2rMAQYxWPY2TF/8
         FRQg==
X-Gm-Message-State: AOJu0Yx6KtsKbbNA1+SmFxZ5tvp5mhaOxISLcXAMZvbspJw60NhmwMTa
	QpdDaNWnorQjqG5gPnSBMTU=
X-Google-Smtp-Source: AGHT+IGvkuDQclWezsmgejSWWlbeBPLQY965xKTM0KEjsRlvuLy+rumoawr7VARF7zWFuOQmMqx0OA==
X-Received: by 2002:ad4:5964:0:b0:66d:9f2e:f3e6 with SMTP id eq4-20020ad45964000000b0066d9f2ef3e6mr14802177qvb.48.1698237562627;
        Wed, 25 Oct 2023 05:39:22 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id pm10-20020ad446ca000000b0066d1f118b7esm4396115qvb.1.2023.10.25.05.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 05:39:22 -0700 (PDT)
Message-ID: <33d37568-e87a-4086-8e01-ecae97b11e3e@gmail.com>
Date: Wed, 25 Oct 2023 05:39:17 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] offchannel: handle out of order ACKs/events
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231023122054.34100-1-prestwoj@gmail.com>
 <a8b3caee-4f9b-4156-b0c2-e9e957897c14@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <a8b3caee-4f9b-4156-b0c2-e9e957897c14@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis

On 10/24/23 7:39 PM, Denis Kenzior wrote:
> Hi James,
> 
> On 10/23/23 07:20, James Prestwood wrote:
>> Its been seen (so far only in mac80211_hwsim + UML) where an
>> offchannel requests ACK comes after the ROC started event. This
>> causes the ROC started event to never call back to notify since
>> info->roc_cookie is unset and it appears to be coming from an
>> external process.
>>
>> We can detect this situation in a few ways, first by looking up
>> the offchannel info by both wdev and cookie. If found, continue
>> as normal. If not lookup by only wdev and if there is still no
>> roc_cookie set the cookie from the notify callback to a temporary
>> 'early_cookie' placeholder and return. This can be checked in
>> the ACK and if it matches we know the ACK came out of order and
>> the started event can be sent.
>>
>> This also handles external process case. If we got a spurious
>> notify event before the ACK, the ACK callback will fail to
>> verify the early cookie, set roc_cookie correctly, and the expected
>> ROC event will come and issue started. Since there should be at
>> most one ROC session per wdev we can assume the temporary
>> early_cookie won't be overwritten.
>>
>> Another minor change was made to the lookup on the cancel path.
>> Instead of looking up by wdev, lookup by the ID itself. We
>> shouldn't ever have more than one info per wdev in the queue but
>> looking up the _exact_ info structure doesn't hurt in case things
>> change in the future.
>> ---
>>   src/offchannel.c | 73 ++++++++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 65 insertions(+), 8 deletions(-)
>>
>> v2:
>>   * Skip started if the event came early, and start in the ACK
>>   * Add check for roc_cookie && roc_cmd_id in notify event. This
>>     verifies that we actually have a pending request, if not it
>>     came externally.
>>   * Add 'early_cookie' placeholder to guard against the case of an
>>     external event coming before the ACK. Prior, this would have
>>     set roc_cookie to an incorrect cookie and called the started
>>     callback prematurely.
>>
> 
> <snip>
> 
>> @@ -98,9 +118,19 @@ static void offchannel_roc_cb(struct l_genl_msg 
>> *msg, void *user_data)
>>           goto work_done;
>>       }
>> -    /* This request was cancelled, and ROC needs to be cancelled */
>> +    /*
>> +     * If this request was cancelled prior to the request ever 
>> hitting the
>> +     * kernel, cancel now.
> 
> This comment makes no sense.  If we're here, then the request hit the 
> kernel as best we can tell (it was sent on the socket).

Yeah what I meant was:

The request was canceled before the kernel ACKed.

> 
>> +     *
>> +     * If the ROC event came before the ACK, call back now since the
>> +     * callback was skipped in the notify event. There is the 
>> potential that
>> +     * an external process issued the ROC, but if the cookies don't 
>> match
>> +     * here we can be sure it wasn't for us.
>> +     */
>>       if (info->needs_cancel)
>>           offchannel_cancel_roc(info);
>> +    else if (info->early_cookie == info->roc_cookie && info->started)
>> +        info->started(info->user_data);
>>       return;
>> @@ -191,7 +221,8 @@ void offchannel_cancel(uint64_t wdev_id, uint32_t id)
>>       else if (ret == false)
>>           goto work_done;
>> -    info = l_queue_find(offchannel_list, match_wdev, &wdev_id);
>> +
>> +    info = l_queue_find(offchannel_list, match_id, &id);
>>       if (!info)
>>           return;
> 
> So I split this chunk out into a separate commit and applied this.  
> Please double check that I didn't screw anything up.
> 
>> @@ -246,6 +277,7 @@ work_done:
>>   static void offchannel_mlme_notify(struct l_genl_msg *msg, void 
>> *user_data)
>>   {
>>       struct offchannel_info *info;
>> +    struct match_data match = {0};
>>       uint64_t wdev_id;
>>       uint64_t cookie;
>>       uint8_t cmd;
>> @@ -261,12 +293,37 @@ static void offchannel_mlme_notify(struct 
>> l_genl_msg *msg, void *user_data)
>>                       NL80211_ATTR_UNSPEC) < 0)
>>           return;
>> -    info = l_queue_find(offchannel_list, match_wdev, &wdev_id);
>> +    match.wdev_id = wdev_id;
>> +    match.cookie = cookie;
>> +
>> +    info = l_queue_find(offchannel_list, match_info, &match);
>> +    if (!info) {
>> +        /* Try again without cookie */
>> +        match.cookie = 0;
>> +        info = l_queue_find(offchannel_list, match_info, &match);
>> +    }
>> +
> 
> I think this can be further nailed down as follows:
> 
> - Search by cookie, wdev and info->roc_cmd_id being 0.  That is our 
> 'normal' case where we sent the ROC, get the ack, and the ROC event 
> comes in.  Handle it normally and return.
> 
> If that fails, then search by wdev, info->rcmd_id_id != 0 and 
> l_genl_family_request_sent is true.  If you don't find anything, then 
> this request is from outside iwd.  This logic might be better as a for 
> loop based on l_queue_get_entries().
> 
> Otherwise, set the early_cookie and return.
> 
>>       if (!info)
>>           return;
>> -    /* ROC must have been started elsewhere, not by IWD */
>> -    if (info->roc_cookie != cookie)
>> +    /*
>> +     * If the cookie is zero and there is a pending ROC command there 
>> are
>> +     * two possibilities:
>> +     *   - The ACK callback came out of order. This has been seen in UML
>> +     *     when an offchannel request is canceled followed by another
>> +     *     request on the same channel. To handle this delay the started
>> +     *     callback until the ACK comes in when we can check the cookie.
>> +     *
>> +     *   - Event came from external process doing ROC. Checking the 
>> cookie
>> +     *     in the ACK lets us verify if this is the case.
>> +     *
>> +     * If the cookie is set but does not match, this ROC request came 
>> from
>> +     * outside IWD.
> 
> This last sentence probably belongs in the "If you don't find anything" 
> part above.
> 
>> +     */
>> +    if (!info->roc_cookie && info->roc_cmd_id) {
>> +        info->early_cookie = cookie;
>> +        return;
>> +    } else if (info->roc_cookie != cookie)
> 
> What does this do?

Handling the external process case. But since I added && 
info->roc_cmd_id above it should actually check that info->roc_cookie 
!=0 && roc_cookie != cookie. But your suggestion above covers all the 
bases, I'll do that.

Thanks,
James

> 
>>           return;
>>       switch (cmd) {
> 
> Regards,
> -Denis
