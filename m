Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D221111B
	for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 20:35:40 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id i8-20020a17090aee8800b001ecc929d14dso2300522pjz.0
        for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 13:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=IvNMzT4O+us/Cpn6R2ParIaxcTpUEwsEurb7CYXgSMM=;
        b=HemKuTVIDx8wKutVDHwmX4QYB64OUiJ+DoIRAoUdHRVnDgK7divxRybOhBVtX76mLh
         IMpU1/lADpb4MbjqEOixQqMvbqjY/ieFsCwJZ0a0QhKTcJJijjf6BJKAxQx8FFp9phjW
         W0+xIe4MlCezOJom6WD9SdsQkKLFnMGpTrTxbjzfExFpFMYT55/ancGEgrsstmPVRlf2
         9l7BE+oQTmwxS6aU/cT57k0yKTbVax+SGJ7RbPOzkERwF203xYC3/Ddmw/DW1oROEg1B
         SIt/OcmlWxPcR0cv9dimNX1D7uBnvPLDsiPnpbPs14GHJ3isMi4jqhwVNDpu8zNDlAc3
         eBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IvNMzT4O+us/Cpn6R2ParIaxcTpUEwsEurb7CYXgSMM=;
        b=8OFnoKAkrePjCzU4PgGNg4T8JWSbwJz9exQo6lUyJjWKByIsVL+WUdVFNlU038FS4W
         DaBjn/t7Vm+RqIkjtcGytnZOv/kRtKPpO36/cn3fY/FTMcJcfSsqwV9pPyg2CwB92FnR
         G28W+jnH+of8I/7s/2QScce6mNKksifPmCH0IHcCK3VrYQ/mPz09LeWMZRDMyc8uen50
         06XE5Pd0oyx1Ln0Ubiv/kuRFURnv0O34AeuZX5AKGuT9Jc38H9KLLZTS6lfSuWP+Jx8m
         ygGQKP/tyLfvDWDt7AH8Vo21lqgwUD2XQAvJYeK6OqfrzbHb5cDUSpXoQjF7FTZ4cqc+
         QG0A==
X-Gm-Message-State: AJIora+GQoRMblxzAdatKWsmLUj0AJrPR1t3kG8AD1vI/koNqYV0VZF6
	J1GaMzFzCiaq3JzKB+ciYMUoQOahfxU=
X-Google-Smtp-Source: AGRyM1tD+JvMOdVnFlSkzhQjQ0i/0OwV+u75aXkJuS7rzCd8ai7H2ykE8cTv+Mp0qb07LOU6+bMxgQ==
X-Received: by 2002:a17:90b:1117:b0:1ea:58d2:85d3 with SMTP id gi23-20020a17090b111700b001ea58d285d3mr180089pjb.167.1655930139635;
        Wed, 22 Jun 2022 13:35:39 -0700 (PDT)
Received: from [192.168.254.55] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id h14-20020a170902f7ce00b0016909678e2csm8999424plw.292.2022.06.22.13.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 13:35:39 -0700 (PDT)
Message-ID: <312b2cd5fdede0d7fdd7f45aeda5919e9b22950f.camel@gmail.com>
Subject: Re: [PATCH 2/2] doc: Add State and Role properties to DPP API
From: James Prestwood <prestwoj@gmail.com>
To: Jesse Lentz <jesse@twosheds.org>, iwd@lists.linux.dev
Date: Wed, 22 Jun 2022 13:35:38 -0700
In-Reply-To: <20220622194142.213135-2-jesse@twosheds.org>
References: <20220622194142.213135-1-jesse@twosheds.org>
	 <20220622194142.213135-2-jesse@twosheds.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jesse,

On Wed, 2022-06-22 at 15:41 -0400, Jesse Lentz wrote:
> Document the State and Role properties of the DeviceProvisioning API.
> ---
>  doc/device-provisioning-api.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/doc/device-provisioning-api.txt b/doc/device-
> provisioning-api.txt
> index 0aba2557..c1d706ec 100644
> --- a/doc/device-provisioning-api.txt
> +++ b/doc/device-provisioning-api.txt
> @@ -56,3 +56,13 @@ Methods              string StartEnrollee()
>                                                 net.connman.iwd.NotCo
> nfigured
>                                                 net.connman.iwd.NotSu
> pported
>                                                 net.connman.iwd.Busy
> +
> +Properties     string State [readonly, optional]
> +
> +                       Reflects the DPP state. Possible values are
> "presence",
> +                       "authenticating", and "configuring".

I think a "stopped" state would also be needed.

> +
> +               string Role [readonly, optional]
> +
> +                       Reflects the DPP role. Possible values are
> "enrollee"
> +                       and "configurator"

I don't think you actually need this one. The role should be implied by
however you started DPP:

StartEnrollee() -> enrollee
StartConfigurator() -> configurator
ConfigureEnrollee() -> configurator

Thanks,
James

