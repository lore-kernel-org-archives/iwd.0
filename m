Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0770186E26
	for <iwd@lists.linux.dev>; Thu, 30 May 2024 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078287; cv=none; b=TP1YiMqwonwLngZRBpc2kNJiEqQr7rr8LBSCZZLHlhRqthf9pE3GnWYD9Exq+fiLXu84hWco3cSfjrysaxp8DbPpXbAKweKfJXNbEZQlNRddVtcMnbViTCuMVKYPqH26qJbQWOCk3IU/TWuW7tVyIPjvhiO8qjMhFkCpdAyxxFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078287; c=relaxed/simple;
	bh=sNL7MNpxhgOZJndjzX987wGJOR1Y4n2nnsRHB016Cf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZKc0ub37reJOL3V+RTV8V8oibB5zfulswvMGrXvn2hNJBvB4sUG7uJB1MnIrwPXzGeSpKV6R5d545t/UP1qey8viTOCnlEIrpVheNoTF390SVkb1DGz50XQ915cExbmUe/v8JqqtyOSBU6myIl4ubobTKLTf43s+Q+mdoeG7A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bB9zSGrN; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB9zSGrN"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43fc6795babso4929421cf.1
        for <iwd@lists.linux.dev>; Thu, 30 May 2024 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717078285; x=1717683085; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=teFTYB0go926pRpYPu0hOlHWs27/dw8yR0ueYoPpBS0=;
        b=bB9zSGrNDupeI5qSDf816dyk6SFvdzOA9kXP16KYc8izHnrDupix0oxsXVHs1BtkhP
         TTwcRxrlWhEDlOAH+HOZeUDpk+GP3HccW62JENTAU3QaQ7Eig0F7Jmr6L6gDN6Dp1aqA
         wwdlSY8Q6p9pQGeFBrzDulcAk7EitokNKBJSM6Uwe3JrN7cQR76wae66RBK5ZVgdNVll
         PG3zXcJTxEe3IWm11/63pabQTx69QdRW7N6D33bA5bntxMT4ChqKH3fTO44Bdw8ROoXE
         s/oO9E6F4cd7KJnpjEGZpVWsM/WGhTUgyqbDOp9Nw+o7VW3UM0Hg47HWkTE+2rNU4VrW
         9QtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717078285; x=1717683085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=teFTYB0go926pRpYPu0hOlHWs27/dw8yR0ueYoPpBS0=;
        b=H3piTdLNhol3h2hJsMJGKZ/OSOSxMmPRgCyvZGGIdnJMirWNMgApJIEkXcQc2T2qb7
         0xchuzt9VPK3j9c7SbPi4D0N1YWPWuOiJe94/aUTw/IL3yE9NPyo0Tfty5mtqLqXhBNj
         GSohy7WVPx7DVM2pzVzMv5nxMgbeWRFJzzDeupJ7yYySWxiwiGnDW+Iyx0zL27spw103
         QWP42XLoNGTqoTnjZVwLQEq2qOyzoldLmR9ziJpvKbVnGGZfLGQ+cMLpHSWOWrHrDQOp
         LBXimcRsJcZUgRnMauiXNfocjmS00Y6dZs1DjJvWrcp5zqo/86o6bTH9BuAS2nwzg37D
         J8Dw==
X-Gm-Message-State: AOJu0Yy4WIF1aPWzQejoBldjkl3IrmpvybFb53sYcnlupEqJD/ik1VSM
	oyozg/VXRmrLaOnp2KCZ1qdAJfwYi45x2OXpOo0BSb95OEFDJmwh
X-Google-Smtp-Source: AGHT+IGuUKMvGvkG60C7HkPva3B2Y7jW5GTKExjFj1ghZmaucBJrAgYckSgnOLZM14xR3eP46tFb7g==
X-Received: by 2002:a05:622a:188f:b0:43a:9715:9e17 with SMTP id d75a77b69052e-43fe92a83efmr29642211cf.14.1717078284486;
        Thu, 30 May 2024 07:11:24 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff0a51433sm914931cf.0.2024.05.30.07.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 07:11:24 -0700 (PDT)
Message-ID: <5b5e743f-e3fb-43ae-9aea-b6b7530d33a4@gmail.com>
Date: Thu, 30 May 2024 07:11:22 -0700
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
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <41FLzNr1wtrsfKFkZM0rMARBMcMTku8jAsn-Jgrsq1FO_Toq-t41UDHVXmSL9P7qSld0ULkyhImIup0G3M33hZZ6ADdntSK00735qr_AeNs=@peeters.gent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/30/24 6:40 AM, Laura Peeters wrote:
> Hi James,
>
> On Thursday, 30 May 2024 at 15:10, James Prestwood <prestwoj@gmail.com> wrote:
>> My interpretation is that spec is somewhat ambiguous on this... The L
>> flag indicates the frame is fragmented:
> not really true, the M flag indicates that the frame is fragmented,
> the L flag indicates that the Message Length is included (which is redundant in unfragmented frames)
>
> "Unfragmented messages MAY have the L bit set and include
> the length of the message (though this information is redundant)."
> — RFC 5281, Section 9.2.2
>
> This paragraph is actually quoted in the relevant code in `eap_tls_init_request_assembly()`
> That code then correctly returns -ENOMSG, however, if tls_msg_len==0 we never hit that code and return with -EINVAL earlier

Ah, I should have kept following the logic. I see we do handle -ENOMSG 
specially up the stack. I still think its weird that the included length 
is zero though. Based on the code the original handling of this 
redundant length case only pertained to the lengths matching. But yes we 
could handle this case by adding:

if (tls_msg_len == len || tls_msg_len == 0) {
     ...
     return -ENOMSG;
}

And of course moving that check earlier.

I think it would be useful to get a bit more information about this from 
the standpoint of freeradius as well as other radius implementations. 
e.g. is this just a bug or a feature introduced in freeradius 3.2.4, or 
did the config change on your network. Do other radius implementations 
have/support this behavior?

At the moment I still don't think this is a "bug" on the IWD side, but 
ambiguity in the spec. Yes the length is labeled as "redundant" in this 
case but what exactly does that mean? should it be ignored? I really 
don't know.

Thanks,

James

>
>> "The L flag is set to indicate the presence of the four-octet TLS
>> Message Length field, and MUST be set for the first fragment of a
>> fragmented TLS message or set of messages."
>>
>> So a fragmented packet with a length of zero certainly makes no sense at
>> all IMO.
>>
>> But this is is set in a TLS-Start message since the S flag is set
>> (right?). I can't find anything to indicate if you can fragment a
>> TLS-Start message, except broadly:
>>
>> "TLS handshake messages SHOULD NOT be fragmented into multiple TLS
>> records if they fit within a single TLS record."
>>
>> I quickly googled around and this all appears to be a configurable
>> option in freeradius. I can't link to the section directly but in this
>> docs page [1] there appears to be a configurable "length_included" option:
> while turning that off is indeed likely to "fix" this issue, the documentation of that parameter states:
>
>    #  This configuration item is here only to work around
>    #  historical issues with misbehaving clients.  In most cases,
>    #  it does not need to be changed.
>
> Which would classify iwd as a misbehaving client according to the freeradius developers.
>
> Given that iwd already correctly handles the L flag being present in unfragmented frames for tls_msg_len > 0 I still believe this is an iwd bug.
>   
> Greetings
> Laura
>
> ps: I'm not on the list (given that I'm mostly just a (code-savy) user), so please keep me cc-ed on this issue.
