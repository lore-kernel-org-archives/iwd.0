Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643EB1E532
	for <iwd@lists.linux.dev>; Thu, 30 May 2024 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081414; cv=none; b=dV4lEYLouhdGw1FBWUPOHMMFWvSnw5jmQeg+q0mf9m2Dpz9sRCekW39cS4maTa4ival+Cql2UP5JVOdy+PNVMlSWQ70zcjhR0KPxaoOp+vLxpF99EmXnDj0U56b1jNg+gZ6FPYWTIy7CBZwiZVtbO1ATWAHIEPty2EiHSk5VGfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081414; c=relaxed/simple;
	bh=5B+jBCxE0Zxa3Df4FQhFvSHQeuh2hGfTWIk/Pyc2fmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/Eys7an0tfq9dzOKklGtLQleGAiKLMbZi+q9802HpIJpIhnxWCg0db//Ch3MiEqoJfU2eM+WVitHsN1ubJ6ptPwbGobHzWNxhaNQT1lN8TOdff2wcPKvY6CvdGUtb/qnVjkdjZuNTTcDsGh/G8D64n6H0A6xJndoet1y8jVSdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVw1j+OQ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVw1j+OQ"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43fc6795babso5256781cf.1
        for <iwd@lists.linux.dev>; Thu, 30 May 2024 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717081411; x=1717686211; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSDWnL445iCxJ+PDNhrWDKzMxSbq/f6DNmirt57wRo8=;
        b=cVw1j+OQdYM3BCW37As8vK0q3YHbomFEe351Y/egwA/MagbAUnr/UNekHiw1YRysZz
         PiM6lbpjSDToV77X82VQRyyPVy3sJ01PnpIRxT9GUJkM0rhzTkS5cvSfCfqTabbA7rCI
         gaxkhj1oyibdm1gKRQ955IIyF+oeKxbklsZMS2qKHwSonpKAGQ0B/XhflnoAJq34A5As
         D1e3qkPRZfpwDYg8aCcuaxiOFZmFXFssAK/gsLjlxjBHJbt70+GYcXqooLhe15HpIBi2
         B05Oezuy+P1aB4WPAkju1aB6s/mRZlZKcIkTfaoMjPR3JQKZy8vBrUmb+jXZVQGKojJs
         ZjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717081411; x=1717686211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSDWnL445iCxJ+PDNhrWDKzMxSbq/f6DNmirt57wRo8=;
        b=PmnhvB+Uf57Olxie5JJPxHiWNUIwaR+ZNrWlLw77wn7vuUiYun9GtiQq0J7PB/pdVq
         90dHFNzth7ufiKNaOqmB3xf3z74il2+0UzOoYq66Ftks3Ttqr5G+zvbdOUyFUBKC95mn
         SugcZvtReDahOKz28k5WVUiRWcx4DFRMe0X8T1XzQNmczENO5FU5z9pTaeoXL0vH7ntP
         gOgqZ0ulJ0tWil/DEzWv57IKtrSk9oxI4rl11D+j4LjAzwrEcfoNvznpgg/lZ0J07h01
         PXOSmWITAlsDSU/Lqy7CVcZMSWEJbvF0CoVkwHXmiFCi0uibkXPJQr72fmr9rJK46iEK
         T0fA==
X-Gm-Message-State: AOJu0Yx6MaPZNWiYGKWqZKu+5GtwDTkIe0dumUfUWaZT5qWIeI0/Yr62
	WmjVmejAjL4HyCydYngoimeFhEcEiiurhJL/zNkeh6oV7Vyj4POt
X-Google-Smtp-Source: AGHT+IHI6K9O43gQi9ApwwrHlIwwkfLfsziHCIXawfYgvXH6paARgEKnkuRkCIM67OtotuRjPxswWA==
X-Received: by 2002:a05:622a:1809:b0:43a:e984:81b with SMTP id d75a77b69052e-43fe92a86d9mr26540521cf.8.1717081410981;
        Thu, 30 May 2024 08:03:30 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb18c2861sm65937631cf.93.2024.05.30.08.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 08:03:30 -0700 (PDT)
Message-ID: <caf730ab-8619-4354-9be0-1f3615f4fb0b@gmail.com>
Date: Thu, 30 May 2024 08:03:28 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug when ttls start message is sent with tls_msg_len=0?
To: Laura Peeters <laura@peeters.gent>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <tpitoeMEXJxiLQiWJBuau4l3V6w-zuBf8bQVFFXHyArcn6AZBp4Mb5TLsDLxqMLgD_uGDNQ2eKnChB5wbsB82NZpb-KdBfCYrnVcm5kDFRs=@peeters.gent>
 <5efbc990-b2fa-4bc0-864f-8d33b54407f3@gmail.com>
 <41FLzNr1wtrsfKFkZM0rMARBMcMTku8jAsn-Jgrsq1FO_Toq-t41UDHVXmSL9P7qSld0ULkyhImIup0G3M33hZZ6ADdntSK00735qr_AeNs=@peeters.gent>
 <5b5e743f-e3fb-43ae-9aea-b6b7530d33a4@gmail.com>
 <l4bFTgc6F3Oq80Dymz6VJAGQB__Pk3Es1NIPcSFxe_-1QEn0748-s9jJxglFtzwRJ01E7iTSOfR8uCes7Adqk7WZQX8nfMKaBm1TpJYfzjs=@peeters.gent>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <l4bFTgc6F3Oq80Dymz6VJAGQB__Pk3Es1NIPcSFxe_-1QEn0748-s9jJxglFtzwRJ01E7iTSOfR8uCes7Adqk7WZQX8nfMKaBm1TpJYfzjs=@peeters.gent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/30/24 7:33 AM, Laura Peeters wrote:
> On Thursday, 30 May 2024 at 16:11, James Prestwood <prestwoj@gmail.com> wrote:
>> On 5/30/24 6:40 AM, Laura Peeters wrote:
>>
>>> Hi James,
>>>
>>> On Thursday, 30 May 2024 at 15:10, James Prestwood prestwoj@gmail.com wrote:
>>>
>>>> My interpretation is that spec is somewhat ambiguous on this... The L
>>>> flag indicates the frame is fragmented:
>>>> not really true, the M flag indicates that the frame is fragmented,
>>>> the L flag indicates that the Message Length is included (which is redundant in unfragmented frames)
>>> "Unfragmented messages MAY have the L bit set and include
>>> the length of the message (though this information is redundant)."
>>> — RFC 5281, Section 9.2.2
>>>
>>> This paragraph is actually quoted in the relevant code in `eap_tls_init_request_assembly()`
>>> That code then correctly returns -ENOMSG, however, if tls_msg_len==0 we never hit that code and return with -EINVAL earlier
>>
>> Ah, I should have kept following the logic. I see we do handle -ENOMSG
>> specially up the stack. I still think its weird that the included length
>> is zero though. Based on the code the original handling of this
>> redundant length case only pertained to the lengths matching. But yes we
>> could handle this case by adding:
>>
>> if (tls_msg_len == len || tls_msg_len == 0) {
>> ...
>> return -ENOMSG;
>> }
>>
> I'd have to double check, but I do not think that an extra `tls_msg_len == 0` check is needed.
>  From what I read `len` should also be 0 at that point. (if it is not then it IS a malformed message)
> So my proposal would just be:
>
> --- a/src/eap-tls-common.c
> +++ b/src/eap-tls-common.c
> @@ -500,9 +500,9 @@ static int eap_tls_init_request_assembly(struct eap_state *eap,
>          tls_msg_len = l_get_be32(pkt);
>          len -= 4;
>   
> -       if (!tls_msg_len || tls_msg_len > EAP_TLS_PDU_MAX_LEN) {
> +       if (tls_msg_len > EAP_TLS_PDU_MAX_LEN) {
>                  l_warn("%s: Fragmented pkt size is outside of allowed"
> -                               " boundaries [1, %u]", eap_get_method_name(eap),
> +                               " boundaries [0, %u]", eap_get_method_name(eap),
>                                                          EAP_TLS_PDU_MAX_LEN);
>   
>                  return -EINVAL;
>
> I'll likely build iwd with this change for testing later. (though I'm not sure when I'll be at the office next)
>
>> And of course moving that check earlier.
>>
>> I think it would be useful to get a bit more information about this from
>> the standpoint of freeradius as well as other radius implementations.
>> e.g. is this just a bug or a feature introduced in freeradius 3.2.4, or
>> did the config change on your network. Do other radius implementations
>> have/support this behavior?
> I am not in contact with freeradius people, but this is a result from a small refactor on their end.
> They used to have a dedicated codepath for sending the start message,
> while in 3.2.4 the regular "send eap tls message" codepath is used with an extra flag to set the start flag.
>
> While I'm not convinced the change in L flag behaviour was intentional, it in my opinion still does not violate the RFC.
Interesting. But makes sense that behavior changes don't get caught if 
clients don't behave any different.
>
> The config on our network did not change, this is purely a (debian) package upgrade that triggered this.
>
> I do not have any experience with/access to other radius implementations to compare.
>
>> At the moment I still don't think this is a "bug" on the IWD side, but
>> ambiguity in the spec. Yes the length is labeled as "redundant" in this
>> case but what exactly does that mean? should it be ignored? I really
>> don't know.
> I think the language "Unfragmented messages MAY have the L bit set" is explicit enough to imply that iwd should not fail if it is set in an unfragmented message. even if that means the length is 0.
>
> Just to be clear here: the message length of 0 IS correct. there is no data after the message length field.
> So "should it be ignored?" doesn't really play into this issue, and I don't think it should be ignored.
> If the length is there, it should be valid, as already enforced by the existing code.
> We just do not end up reaching that code if the length specified is 0.

Ok, sorry, its just hard to really see the full picture without seeing 
the actual packet. I was assuming there was more data, and thinking that 
you wanted to allow a case where tls_msg_len != len (this is why I was 
pushing back). But this makes sense now, after the packet length (len) 
is subtracted by 4 the two lengths will equal each other and that is 
exactly the case your trying to handle.

So yes the above patch would make sense to me.

>
>> Thanks,
>>
>> James
>>
>>>> "The L flag is set to indicate the presence of the four-octet TLS
>>>> Message Length field, and MUST be set for the first fragment of a
>>>> fragmented TLS message or set of messages."
>>>>
>>>> So a fragmented packet with a length of zero certainly makes no sense at
>>>> all IMO.
>>>>
>>>> But this is is set in a TLS-Start message since the S flag is set
>>>> (right?). I can't find anything to indicate if you can fragment a
>>>> TLS-Start message, except broadly:
>>>>
>>>> "TLS handshake messages SHOULD NOT be fragmented into multiple TLS
>>>> records if they fit within a single TLS record."
>>>>
>>>> I quickly googled around and this all appears to be a configurable
>>>> option in freeradius. I can't link to the section directly but in this
>>>> docs page [1] there appears to be a configurable "length_included" option:
>>>> while turning that off is indeed likely to "fix" this issue, the documentation of that parameter states:
>>> # This configuration item is here only to work around
>>> # historical issues with misbehaving clients. In most cases,
>>> # it does not need to be changed.
>>>
>>> Which would classify iwd as a misbehaving client according to the freeradius developers.
>>>
>>> Given that iwd already correctly handles the L flag being present in unfragmented frames for tls_msg_len > 0 I still believe this is an iwd bug.
>>>
>>> Greetings
>>> Laura
>>>
>>> ps: I'm not on the list (given that I'm mostly just a (code-savy) user), so please keep me cc-ed on this issue.
