Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308DA15B12C
	for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834157; cv=none; b=fDo6YSKPSCPbQnkhlNsjsLrv3ol5fyB2+CtAB788HCV93VwUkejKYzXMLVapNPPiC38FD6ve4lcUw7wBB6oktWYbUiTAOzcGEiMHdQ45hHJhrJtywxnREPbl3gBvzJD3V6mVBO67ApUviDgV88+morkJv9fM0EUKxOWN8FSfM94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834157; c=relaxed/simple;
	bh=xVWiY4n1iAjZQ0T1lojQBjOslSGMnaGM1zVOLjcescI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DXqb0js9cM+np5uor1EDU3cE6L52HcRwt3+9n67QH+wKw+JaC6upEINmHHn4OMBvouOfvbu4FuSMgi2v8gAxMl1pMJHzd6VD6t6rCmPfVnKnNASxISL76S57bqD2i2NnTSlXAc99KUKRxnPIGfkjs8SHiOmmlo87This5y5UFSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1O8cOE8; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1O8cOE8"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d9db222782so4010883b6e.3
        for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 08:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721834155; x=1722438955; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dtMktaLcrXGIr/Bx0428I46K6dqxKC4GwzW7ZKugy1A=;
        b=f1O8cOE8h6lM0RWFo02ZlCq4ouZRVYdCv3XbqSa+cE4av52owotN5IjsZ9Dj2ipt2Z
         vEQbHtOVbYTkTpcMUB5OvMcqjfb2dZlVnBdtEnwFjCk152NuLZfKarFUF/pbXpcLTYdu
         XGGsaiE3R32Gn3ZALLFkdFg2AFK0VY5qOun347hZoonSYvNt63RvA6DhPJWnAbB9aSZ2
         4dTEWQmZeH2uwYuGxUWqFKVlmDDvIK7+5v5Pq/SVTQIF7sMgbJPi24kbIF+XkF0Br+7E
         Z/nV3pi3VPei3rL4Cm1E/we46nzAYV988sFdYOdjzcvgyzcRyt0fgA+VNgQTU0pr1NOw
         z4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721834155; x=1722438955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dtMktaLcrXGIr/Bx0428I46K6dqxKC4GwzW7ZKugy1A=;
        b=pPN+T8SNjtuYZVOyhmhOmHm7NR+ZjPWuUTIQqWfsmeVTU9ZAsjFVIolMCOhMYGtC3O
         5r/P7OUcU69hqZNi9unHXuLGxXSn19D/EVPzx/28mHSSc+C6YFB4oNTEIBr1gKtqXQtk
         xFJbwisRJays0MP2I4oFzwJ9N/jni3UrIiSLBcOBXRo70mHBY1Icozq9zkA57eZMBJfE
         Lc0jP4c05dSBF4lWJ1E20qaN2hgjaOnadu5JBxRZPoSN1H8NubVD3/Py88Yrne9uHawX
         N3xP/HixMs22PleTvzb7VObRPojhxpPRL+U5A5hsh/QOfP5e/guWYjrYIQsMdyEOhitM
         ONwg==
X-Forwarded-Encrypted: i=1; AJvYcCWruN8cpXc5B7XR8idgs4As13ffajlKKWOjTWpPWmC2mM1/K2oQub5ad0RfVY1NTCpHSQEE56p+jGGdi07sjRnk2T6K
X-Gm-Message-State: AOJu0YzcKUI3QGeGsHe6bTcFMHpc7BHCf+n4KP2QIUHNyhIu+5jKF4KG
	0REYxkEMnojmqbkmIu39xqDvGOsEaZ/9XKVazRHlS6CpaqOX2CGXt0P+Ug==
X-Google-Smtp-Source: AGHT+IHgvX0zu/RNJgHQgZkGSY5ETyYLtv8pdNNm3wXNrIsNgCSiMnW5WqxrrqOn9hLEjeocWiWa3A==
X-Received: by 2002:a05:6808:30a6:b0:3da:a793:f0df with SMTP id 5614622812f47-3dae629bdf5mr16692091b6e.9.1721834155316;
        Wed, 24 Jul 2024 08:15:55 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3dae0969c8fsm2439865b6e.12.2024.07.24.08.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 08:15:55 -0700 (PDT)
Message-ID: <683fd9f7-f724-4abf-aa6d-883d12b57aae@gmail.com>
Date: Wed, 24 Jul 2024 10:15:54 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] dpp: explicitly disconnect station if enrollee is
 started
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240722182932.4091008-1-prestwoj@gmail.com>
 <20240722182932.4091008-3-prestwoj@gmail.com>
 <a1b40f90-e69b-4b70-80ef-c228fe54be94@gmail.com>
 <09ae7769-63fd-4c61-8cfa-a40dca535c59@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <09ae7769-63fd-4c61-8cfa-a40dca535c59@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>>> +    /* Unusual case, but an enrollee could still be started */
>>> +    if (!station)
>>> +        return false;
>>
>> Function signature returns int, but you're returning false.
> 
> Yep this is intended.
> 
> true for a disconnect has started or is ongoing.
> false for already disconnected
> < 0 for a fatal error (i.e. station_disconnect() failed)
> 

The typical convention is:
-errno -> error
0 - > success

You can extend this to mean that 0...INT_MAX is a success and return value 
simultaneously.  Mixing integers and bools is not what vast majority of people 
would expect and should be avoided.

> If this isn't desirable we could do:
> 
> -EALREADY for a disconnect is started/ongoing
> 0 for already disconnected
> < 0 for a fatal error

That would be better.  Another alternative is:

int dpp_try_disconnect_station(struct dpp_sm *dpp, bool *out_disconnect_started);

Regards,
-Denis
