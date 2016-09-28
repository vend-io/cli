﻿using System;
using System.Collections.Generic;
using Mono.Options;
/**
 * References:
 * https://components.xamarin.com/gettingstarted/mono.options?version=4.2.2.0
 * http://tirania.org/blog/archive/2008/Oct-14.html
 */
namespace CLI {
	class MainClass {
		static int verbosity;

		public static void Main(string[] args) {
			bool show_help = false;
			var names = new List<string>();
			int repeat = 1;

			var p = new OptionSet() {
				{ "n|name=", "the name of someone to greet.",
				  v => names.Add (v) },
				{ "r|repeat=", "the number of times to repeat the greeting.",
				  (int v) => repeat = v },
				{ "v", "increase debug message verbosity",
				  v => { if (v != null) ++verbosity; } },
				{ "h|help",  "show this message and exit",
				  v => show_help = v != null },
			};

			List<string> extra;
			try { extra = p.Parse(args); } catch (OptionException e) {
				Console.Write("greet: ");
				Console.WriteLine(e.Message);
				Console.WriteLine("Try `greet --help' for more information.");
				return;
			}

			if (show_help) {
				ShowHelp(p);
				return;
			}

			string message;
			if (extra.Count > 0) {
				message = string.Join(" ", extra.ToArray());
				Debug("Using new message: {0}", message);
			} else {
				message = "Hello {0}!";
				Debug("Using default message: {0}", message);
			}

			foreach (string name in names) {
				for (int i = 0; i < repeat; ++i)
					Console.WriteLine(message, name);
			}
		}

		static void ShowHelp(OptionSet p) {
			Console.WriteLine("Usage: greet [OPTIONS]+ message");
			Console.WriteLine("Greet a list of individuals with an optional message.");
			Console.WriteLine("If no message is specified, a generic greeting is used.");
			Console.WriteLine();
			Console.WriteLine("Options:");
			p.WriteOptionDescriptions(Console.Out);
		}

		static void Debug(string format, params object[] args) {
			if (verbosity > 0) {
				Console.Write("# ");
				Console.WriteLine(format, args);
			}
		}
	}
}
