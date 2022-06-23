Received: from mail-108-mta154.mxroute.com (mail-108-mta154.mxroute.com [136.175.108.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC621FA6
	for <iwd@lists.linux.dev>; Thu, 23 Jun 2022 19:07:15 +0000 (UTC)
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta154.mxroute.com (ZoneMTA) with ESMTPSA id 18191f6182900028a7.002
 for <iwd@lists.linux.dev>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Thu, 23 Jun 2022 19:07:13 +0000
X-Zone-Loop: 9182f8fd9a2c3586a0f835892899e5770058722480ab
X-Originating-IP: [140.82.40.27]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=twosheds.org; s=x; h=In-Reply-To:References:Cc:To:From:Subject:Message-Id:
	Date:Content-Type:Content-Transfer-Encoding:Mime-Version:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dB64Zte6zJMbEzfH7jyujWs6HavBGaILLhNzEqrYnhM=; b=y95A2GW78qXtHgPl4WB/N9oavu
	r1Q+BETtEmyml7tCds9qgoPsGTzKUlTGL/yh5gar9YaMlkVcC6WnzmK+7l+e7WCG6zCnpve0PryYz
	Tbt+dWCb7ghMDAY6iP32i/6c1Vfjg+N4VIYOcjaXKt6yoqCarklj6PUgktcNM3VjKclvZwC2TPSrb
	GsLt+2cjlIYo2XfsLI6RkdyBC4SL64zhv3o6bKLHWhCW3osxzRyv90wPkvHQ4cO+HnGVX7zPd61Kt
	hJ4M3KP7wDZuBNZPMuyDthkEeURAnsORybCOWZfyFtKyY8QJXLpdVkpi2aIwYbJVGFmzf92n986yR
	yf8WQVSg==;
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jun 2022 15:07:06 -0400
Message-Id: <CKXQZJ5G2LJO.1IJRN5WMBF3DY@laptop>
Subject: Re: [PATCH 2/2] doc: Add State and Role properties to DPP API
From: "Jesse Lentz" <jesse@twosheds.org>
To: "Denis Kenzior" <denkenz@gmail.com>, <iwd@lists.linux.dev>
Cc: 
References: <20220622194142.213135-1-jesse@twosheds.org>
 <20220622194142.213135-2-jesse@twosheds.org>
 <312b2cd5fdede0d7fdd7f45aeda5919e9b22950f.camel@gmail.com>
 <CKXNNPV68RR1.3ROOO4K1DSKL0@laptop>
 <4f8abe30-e9c2-0a35-a913-d67c3242ec3a@gmail.com>
In-Reply-To: <4f8abe30-e9c2-0a35-a913-d67c3242ec3a@gmail.com>
X-AuthUser: jesse@twosheds.org

Hi Denis,

> Inferring the state is fine if you can do this reliably.  One problem wit=
h=20
> optional properties is that once they transition from 'defined' -> 'undef=
ined'=20
> there is no PropertiesChanged signal that is sent (or rather you have to =
look=20
> into the invalidated_properties array of that signal).
>
> We have been designing our APIs with the assumption that many bindings wo=
uldn't=20
> be using this invalidated_properties reliably and added another point of =
reference.
>
> For example, Station.ConnectedNetwork is invalidated when Station.State g=
oes=20
> into the 'disconnected' state and thus not explicitly 'changed'.  But the=
 DBus=20
> client can infer that Station.ConnectedNetwork is 'undefined' at that poi=
nt.
>
> But maybe bindings have improved over the years and we should just rely o=
n=20
> invalidated_properties being taken into account properly?  If so, that wo=
uld be=20
> a good argument to make 'State' optional.

Hmm, I wasn't aware of that. I can only comment on the GLib binding,
which works reliably as far as I can tell - it supplies both changed and
invalidated properties to the user-registered callback, which gets
called in response to both changed and to invalidated properties.

But if other bindings handle it incorrectly, then I suppose there's no
compelling reason to make it an optional property.

Thanks.

Sincerely,
Jesse
